extends Node
class_name ContentCollection

enum SortOrders {EXPANSION, TYPE, RARITY, DISPLAYALL}
enum VersionLevels {EXPANSION, MAJOR, MINOR, PATCH}
const VERSION: Array[int] = [0,0,3,0]

# stored at /home/fenny/.local/share/godot/app_userdata/TTCTCG
const SAVE_LOCATION = "user://DoNotEditOrElseFaceThePenaltyOfDeathSeriouslyBroThatWouldBeVeryUncoolOfYou.cake"
const VERY_SAFE_ENCRYPTION_KEY = "DoNotEditOrElseFaceThePenaltyOfDeathSeriouslyBroThatWouldBeVeryUncoolOfYouPassword"
var collection: Dictionary 
var decks: Dictionary
var timer_charges: int

var next_pack_timestamp: float
var pack_after_that_timestamp: float
#const NEXT_PACK_UNIX_TIME_OFFSET: int = 43200
#const TIMER_CHARGE_VALUE: int = 3600
const NEXT_PACK_UNIX_TIME_OFFSET: int = 120
const TIMER_CHARGE_VALUE: int = 60

var empty_expansion_dict: Dictionary

func _init() -> void:
	var type_dict: Dictionary = {}
	for type in DATA.ContentTypes:
		type_dict[type] = {}
	
	var rarity_dict: Dictionary = {}
	for rarity in DATA.Rarities:
		rarity_dict[rarity] = type_dict.duplicate(true)
	
	var sides_dict: Dictionary = {}
	for side in DATA.ContentSides:
		sides_dict[side] = rarity_dict.duplicate(true)
	
	var expansion_dict: Dictionary = {}
	for ID in DATA.ExpansionIDs:
		expansion_dict[ID] = sides_dict.duplicate(true)
	
	empty_expansion_dict = sides_dict.duplicate(true)
	collection = expansion_dict
	decks = {}

# ======================= #
# collection modification #
# ======================= #
#region
func DEBUG_reset() -> void:
	next_pack_timestamp       = 0
	pack_after_that_timestamp = 0
	timer_charges             = 0
	collection                = {}
	decks                     = {}
	for ID in DATA.ExpansionIDs:
		collection[ID] = empty_expansion_dict.duplicate(true)
	_save()
	
func _recieve_timer_charges(count: int) -> void:
	timer_charges += count
	_save()
func _spend_timer_charges(count: int) -> void:
	if timer_charges >= count: timer_charges -= count
	var t: float = Time.get_unix_time_from_system()
	next_pack_timestamp       = t+NEXT_PACK_UNIX_TIME_OFFSET-fmod(NEXT_PACK_UNIX_TIME_OFFSET+t-next_pack_timestamp, TIMER_CHARGE_VALUE)
	pack_after_that_timestamp = t+NEXT_PACK_UNIX_TIME_OFFSET-fmod(NEXT_PACK_UNIX_TIME_OFFSET+t-next_pack_timestamp, TIMER_CHARGE_VALUE)
	_save()

func _update_pack_timers():
	next_pack_timestamp = pack_after_that_timestamp
	pack_after_that_timestamp = max(Time.get_unix_time_from_system(), next_pack_timestamp)+NEXT_PACK_UNIX_TIME_OFFSET
	_save()

func _recieve_deck(deck: Deck) -> void:
	var deck_dict: Dictionary = deck.reduce_to_dict()
	decks[deck.Name] = deck_dict
	_save()

func _delete_deck(DeckName: String) -> void: 
	decks.erase(DeckName)
	_save()

func _recieve_cards(ExpansionID : DATA.ExpansionIDs, CardList : Array[Card]) -> void:
	var EID = DATA.ExpansionIDs.find_key(ExpansionID)
	var expansion_dict: Dictionary = collection.get_or_add(EID, empty_expansion_dict.duplicate(true))
	var atk_dict: Dictionary = expansion_dict[DATA.ContentSides.find_key(DATA.ContentSides.ATK)]
	var def_dict: Dictionary = expansion_dict[DATA.ContentSides.find_key(DATA.ContentSides.DEF)]
	
	var atk_cards: Array[Card]
	var def_cards: Array[Card]
	for i in range(CardList.size()):
		if i%2: def_cards.append(CardList[i])
		else: atk_cards.append(CardList[i])
	
	var rarity_dict: Dictionary = {}
	for rarity in DATA.Rarities:
		rarity_dict[rarity] = {}
	
	for i in range(atk_cards.size()):
		var atk_card: Card = atk_cards[i]
		var atk_card_rarity: DATA.Rarities = atk_card.Rarity
		var atk_card_type: DATA.ContentTypes = atk_card.Type
		
		var def_card: Card = def_cards[i]
		var def_card_rarity: DATA.Rarities = def_card.Rarity
		var def_card_type: DATA.ContentTypes = def_card.Type
		
		var atk_rarity_type_dict: Dictionary = atk_dict[DATA.Rarities.find_key(atk_card_rarity)][DATA.ContentTypes.find_key(atk_card_type)]
		var atk_card_dict: Dictionary = atk_rarity_type_dict.get_or_add(atk_card.ContentIndex, rarity_dict.duplicate(true))[DATA.Rarities.find_key(def_card_rarity)]
		atk_card_dict.set(def_card.ContentIndex, atk_card_dict.get_or_add(def_card.ContentIndex, 0)+1)
		
		var def_rarity_type_dict: Dictionary = def_dict[DATA.Rarities.find_key(def_card_rarity)][DATA.ContentTypes.find_key(def_card_type)]
		var def_card_dict: Dictionary = def_rarity_type_dict.get_or_add(def_card.ContentIndex, rarity_dict.duplicate(true))[DATA.Rarities.find_key(atk_card_rarity)]
		def_card_dict.set(atk_card.ContentIndex, def_card_dict.get_or_add(atk_card.ContentIndex, 0)+1)
	
	_save()
#endregion

# =========== #
# file access #
# =========== #
#region
func _save() -> Error:
	var file = FileAccess.open_encrypted_with_pass(SAVE_LOCATION, FileAccess.WRITE, VERY_SAFE_ENCRYPTION_KEY)
	if not file: return ERR_FILE_CANT_OPEN
	
	var data = {
		"VERSION" : VERSION,
		"SAVED_AT" : Time.get_unix_time_from_system(),
		
		"NEXT_PACK_TIMESTAMP" : next_pack_timestamp,
		"PACK_AFTER_THAT_TIMESTAMP" : pack_after_that_timestamp,
		
		"COLLECTION"    : collection,
		"DECKS"         : decks,
		"TIMER_CHARGES" : timer_charges
	}
	file.store_var(data)
	file.close()
	return OK

func _load() -> Error:
	if not FileAccess.file_exists(SAVE_LOCATION): return ERR_FILE_NOT_FOUND
	
	var file: FileAccess
	var data: Dictionary
	file = FileAccess.open_encrypted_with_pass(SAVE_LOCATION, FileAccess.READ, VERY_SAFE_ENCRYPTION_KEY)
	if not file: return ERR_FILE_CANT_READ
	
	data = file.get_var()
	file.close()
	if not data: return ERR_INVALID_DATA
	
	if not data.keys().has("VERSION"): 
		LOGGER.log_msg("content_collection.gd: saved data does not contain \"VERSION\" field", LOGGER.Flags.ERR_STDOUT)
		return ERR_INVALID_DATA
	if not data.keys().has("SAVED_AT"): 
		LOGGER.log_msg("content_collection.gd: saved data does not contain \"SAVED_AT\" field", LOGGER.Flags.ERR_STDOUT)
		return ERR_INVALID_DATA
	if not data.keys().has("NEXT_PACK_TIMESTAMP"): 
		LOGGER.log_msg("content_collection.gd: saved data does not contain \"NEXT_PACK_TIMESTAMP\" field", LOGGER.Flags.ERR_STDOUT)
		return ERR_INVALID_DATA
	if not data.keys().has("PACK_AFTER_THAT_TIMESTAMP"): 
		LOGGER.log_msg("content_collection.gd: saved data does not contain \"PACK_AFTER_THAT_TIMESTAMP\" field", LOGGER.Flags.ERR_STDOUT)
		return ERR_INVALID_DATA
	if not data.keys().has("COLLECTION"): 
		LOGGER.log_msg("content_collection.gd: saved data does not contain \"COLLECTION\" field", LOGGER.Flags.ERR_STDOUT)
		return ERR_INVALID_DATA
	if not data.keys().has("DECKS"): 
		LOGGER.log_msg("content_collection.gd: saved data does not contain \"DECKS\" field", LOGGER.Flags.ERR_STDOUT)
		return ERR_INVALID_DATA
	if not data.keys().has("TIMER_CHARGES"): 
		LOGGER.log_msg("content_collection.gd: saved data does not contain \"TIMER_CHARGES\" field", LOGGER.Flags.ERR_STDOUT)
		data["TIMER_CHARGES"] = 0
	
	#if VERSION != data["verison"]: printerr("SAVE FROM PREVIOUS VERSION")
	if Time.get_unix_time_from_system() < data["SAVED_AT"]: 
		LOGGER.log_msg("content_collection.gd: BRUH IS A TIME TRAVELIN' AHH HAHAH", LOGGER.Flags.ERR_STDOUT)
		return ERR_HELP
	if not is_same_version(data["VERSION"]):
		next_pack_timestamp       = 0
		pack_after_that_timestamp = 0
		timer_charges             = 0
		_save()
		LOGGER.log_msg("content_collection.gd: incompatible save file version. resetting collection.", LOGGER.Flags.WARN)
	else:
		next_pack_timestamp       = data["NEXT_PACK_TIMESTAMP"]
		pack_after_that_timestamp = data["PACK_AFTER_THAT_TIMESTAMP"]
		collection                = data["COLLECTION"]
		decks                     = data["DECKS"]
		timer_charges             = data["TIMER_CHARGES"]
		LOGGER.log_msg("content_collection.gd: compatible save file version. loaded collection successfully.")
	return OK
#endregion

func is_same_version(version: Array[int]) -> bool:
	if version.size() != VERSION.size():
		return false
	for level in version:
		if version[level] != VERSION[level]:
			return false
	return true
