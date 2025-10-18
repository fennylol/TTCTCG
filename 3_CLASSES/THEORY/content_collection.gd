extends Node
class_name ContentCollection

enum SortOrders {EXPANSION, TYPE, RARITY, DISPLAYALL}
enum VersionLevels {EXPANSION, MAJOR, MINOR, PATCH}
const VERSION: Array[int] = [0,0,2,2]

# stored at /home/fenny/.local/share/godot/app_userdata/TTCTCG
const SAVE_LOCATION = "user://DoNotEditOrElseFaceThePenaltyOfDeathSeriouslyBroThatWouldBeVeryUncoolOfYou.cake"
const VERY_SAFE_ENCRYPTION_KEY = "DoNotEditOrElseFaceThePenaltyOfDeathSeriouslyBroThatWouldBeVeryUncoolOfYouPassword"
var collection: Dictionary 
var decks: Dictionary

var next_pack_timestamp: float
var pack_after_that_timestamp: float
const NEXT_PACK_UNIX_TIME_OFFSET: int = 10#43200

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
# COLLECTION MODIFICATION #
# ======================= #
#region
func recieve_deck(deck: Deck) -> void:
	var deck_dict: Dictionary = deck.reduce_to_dict()
	decks[deck.Name] = deck_dict
	_save()

func delete_deck(DeckName: String) -> void: 
	decks.erase(DeckName)
	_save()

func recieve_cards(ExpansionID : DATA.ExpansionIDs, CardList : Array[Card]) -> void:
	next_pack_timestamp = pack_after_that_timestamp
	pack_after_that_timestamp = max(Time.get_unix_time_from_system(), next_pack_timestamp)+NEXT_PACK_UNIX_TIME_OFFSET
	
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
# FILE ACCESS #
# =========== #
#region
func _save() -> Error:
	var file = FileAccess.open_encrypted_with_pass(SAVE_LOCATION, FileAccess.WRITE, VERY_SAFE_ENCRYPTION_KEY)
	if not file: return ERR_FILE_CANT_OPEN
	
	var data = {
		"version" : VERSION,
		"saved_at" : Time.get_unix_time_from_system(),
		
		"next_pack_timestamp" : next_pack_timestamp,
		"pack_after_that_timestamp" : pack_after_that_timestamp,
		
		"collection" : collection,
		"decks" : decks
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
	
	if not data.keys().has("version"): 
		LOGGER.log_msg("content_collection.gd: saved data does not contain \"version\" field", LOGGER.Flags.ERR_STDOUT)
		return ERR_INVALID_DATA
	if not data.keys().has("saved_at"): 
		LOGGER.log_msg("content_collection.gd: saved data does not contain \"saved_at\" field", LOGGER.Flags.ERR_STDOUT)
		return ERR_INVALID_DATA
	if not data.keys().has("next_pack_timestamp"): 
		LOGGER.log_msg("content_collection.gd: saved data does not contain \"next_pack_timestamp\" field", LOGGER.Flags.ERR_STDOUT)
		return ERR_INVALID_DATA
	if not data.keys().has("pack_after_that_timestamp"): 
		LOGGER.log_msg("content_collection.gd: saved data does not contain \"pack_after_that_timestamp\" field", LOGGER.Flags.ERR_STDOUT)
		return ERR_INVALID_DATA
	if not data.keys().has("collection"): 
		LOGGER.log_msg("content_collection.gd: saved data does not contain \"collection\" field", LOGGER.Flags.ERR_STDOUT)
		return ERR_INVALID_DATA
	if not data.keys().has("decks"): 
		LOGGER.log_msg("content_collection.gd: saved data does not contain \"decks\" field", LOGGER.Flags.ERR_STDOUT)
		return ERR_INVALID_DATA
	
	#if VERSION != data["verison"]: printerr("SAVE FROM PREVIOUS VERSION")
	if Time.get_unix_time_from_system() < data["saved_at"]: 
		LOGGER.log_msg("content_collection.gd: BRUH IS A TIME TRAVELIN' AHH HAHAH", LOGGER.Flags.ERR_STDOUT)
		return ERR_HELP
	
	next_pack_timestamp = data["next_pack_timestamp"]
	pack_after_that_timestamp = data["pack_after_that_timestamp"]
	collection = data["collection"]
	decks = data["decks"]
	return OK
#endregion
