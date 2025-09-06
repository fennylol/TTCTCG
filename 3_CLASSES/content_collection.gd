extends Node
class_name ContentCollection

enum SortOrders {EXPANSION, TYPE, RARITY, DISPLAYALL}
enum VersionLevels {MAJOR, MINOR, PATCH}
const VERSION: Array[int] = [0,0,0]

# stored at /home/fenny/.local/share/godot/app_userdata/TTCTCG
const SAVE_LOCATION = "user://DoNotEditOrElseFaceThePenaltyOfDeathSeriouslyBroThatWouldBeVeryUncoolOfYou.cake"
const VERY_SAFE_ENCRYPTION_KEY = "DoNotEditOrElseFaceThePenaltyOfDeathSeriouslyBroThatWouldBeVeryUncoolOfYouPassword"
var collection: Dictionary 
var decks: Array[Deck]


var empty_expansion_dict: Dictionary

func _init() -> void:
	#var rarity_dict: Dictionary = {}
	#for rarity in DATA.Rarities:
		#rarity_dict[rarity] = {}
	
	#for ID in DATA.ExpansionIDs:
		#collection[ID] = rarity_dict.duplicate(true)
	
	var rarity_dict: Dictionary = {}
	for rarity in DATA.Rarities:
		rarity_dict[rarity] = {}
	
	var type_dict: Dictionary = {}
	for type in DATA.ContentTypes:
		type_dict[type] = rarity_dict.duplicate(true)
	
	var sides_dict: Dictionary = {}
	for side in DATA.ContentSides:
		sides_dict[side] = type_dict.duplicate(true)
	
	var expansion_dict: Dictionary = {}
	for ID in DATA.ExpansionIDs:
		expansion_dict[ID] = sides_dict.duplicate(true)
	
	empty_expansion_dict = sides_dict.duplicate(true)
	collection = expansion_dict
	decks = []


func recieve_cards(ExpansionID : DATA.ExpansionIDs, CardList : Array[Card]):
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
		var atk_card_type: DATA.ContentTypes = atk_card.Type
		var atk_card_rarity: DATA.Rarities = atk_card.Rarity
		
		var def_card: Card = def_cards[i]
		var def_card_type: DATA.ContentTypes = def_card.Type
		var def_card_rarity: DATA.Rarities = def_card.Rarity
		
		var atk_type_rarity_dict: Dictionary = atk_dict[DATA.ContentTypes.find_key(atk_card_type)][DATA.Rarities.find_key(atk_card_rarity)]
		var atk_card_dict: Dictionary = atk_type_rarity_dict.get_or_add(atk_card.SetID, rarity_dict.duplicate(true))[DATA.Rarities.find_key(def_card_rarity)]
		atk_card_dict.set(def_card.SetID, atk_card_dict.get_or_add(def_card.SetID, 0)+1)
		
		var def_type_rarity_dict: Dictionary = def_dict[DATA.ContentTypes.find_key(def_card_type)][DATA.Rarities.find_key(def_card_rarity)]
		var def_card_dict: Dictionary = def_type_rarity_dict.get_or_add(def_card.SetID, rarity_dict.duplicate(true))[DATA.Rarities.find_key(atk_card_rarity)]
		def_card_dict.set(atk_card.SetID, def_card_dict.get_or_add(atk_card.SetID, 0)+1)
	
	_save()

#func recieve_cards(ExpansionID : DATA.ExpansionIDs, CardList : Array[Card]):
	#var EID = DATA.ExpansionIDs.find_key(ExpansionID)
	#var expansion_dict: Dictionary = collection[EID]
	#
	#for card in CardList:
		#var rarity_dict: Dictionary = expansion_dict[DATA.Rarities.find_key(card.Rarity)] 
		#rarity_dict.set(card.SetID, rarity_dict.get_or_add(card.SetID, 0)+1)
	#
	#_save()

func _save():
	var file = FileAccess.open_encrypted_with_pass(SAVE_LOCATION, FileAccess.WRITE, VERY_SAFE_ENCRYPTION_KEY)
	if not file: return ERR_FILE_CANT_OPEN
	
	var data = {
		"version" : VERSION,
		"saved_at" : Time.get_datetime_string_from_system(true),
		"collection" : collection,
		"decks" : decks
	}
	file.store_var(data)
	file.close()

func _load() -> Error:
	if not FileAccess.file_exists(SAVE_LOCATION): return ERR_FILE_NOT_FOUND
	
	var file: FileAccess
	var data: Dictionary
	file = FileAccess.open_encrypted_with_pass(SAVE_LOCATION, FileAccess.READ, VERY_SAFE_ENCRYPTION_KEY)
	if not file: return ERR_FILE_CANT_READ
	
	data = file.get_var()
	file.close()
	if not data: return ERR_INVALID_DATA
	
	collection = data["collection"]
	decks = []#Deck.parse_deck_list(data["decks"])
	return OK

#func _save_JSON():
	#var file = FileAccess.open(SAVE_LOCATION, FileAccess.WRITE)
	#var json := JSON.stringify(collection)
	#file.store_string(json)
	#file.close()
#
#func _load_JSON():
	#if FileAccess.file_exists(SAVE_LOCATION):
		#var file = FileAccess.open(SAVE_LOCATION, FileAccess.READ)
		#collection = JSON.parse_string(file.get_as_text())
		#file.close()
	#DEBUG_print_collection()
