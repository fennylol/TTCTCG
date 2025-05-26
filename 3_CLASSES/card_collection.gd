extends Node
class_name ContentCollection

# stored at /home/fenny/.local/share/godot/app_userdata/TTCTCG
const SAVE_LOCATION = "user://DoNotEditOrElseFaceThePenaltyOfDeathSeriouslyBroThatWouldBeVeryUncoolOfYou.json"

var collection: Dictionary 

func _init() -> void:
	var rarity_dict: Dictionary = {}
	for rarity in DATA.Rarities:
		rarity_dict[rarity] = {}
	
	for ID in DATA.ExpansionIDs:
		collection[ID] = rarity_dict.duplicate(true)

func recieve_cards(ExpansionID : DATA.ExpansionIDs, CardList : Array[Card]):
	var EID = DATA.ExpansionIDs.find_key(ExpansionID)
	var expansion_dict: Dictionary = collection[EID]
	
	for card in CardList:
		var rarity_dict: Dictionary = expansion_dict[DATA.Rarities.find_key(card.Rarity)] 
		rarity_dict.set(card.SetID, rarity_dict.get_or_add(card.SetID, 0)+1)
	
	_save()

func _save():
	var file = FileAccess.open(SAVE_LOCATION, FileAccess.WRITE)
	file.store_var(collection)
	file.close()

func _load():
	if FileAccess.file_exists(SAVE_LOCATION):
		var file = FileAccess.open(SAVE_LOCATION, FileAccess.READ)
		collection = file.get_var()
		file.close()
	DEBUG_print_collection()

func _save_JSON():
	var file = FileAccess.open(SAVE_LOCATION, FileAccess.WRITE)
	var json := JSON.stringify(collection)
	file.store_string(json)
	file.close()

func _load_JSON():
	if FileAccess.file_exists(SAVE_LOCATION):
		var file = FileAccess.open(SAVE_LOCATION, FileAccess.READ)
		collection = JSON.parse_string(file.get_as_text())
		file.close()
	DEBUG_print_collection()

func DEBUG_print_collection():
	for ID in DATA.ExpansionIDs:
		for rarity in DATA.Rarities:
			print("\n", ID, " - ", rarity,": ")
			for key in collection[ID][rarity].keys():
				print("   ", DATA.get_expansion_content(DATA.ExpansionIDs.get(ID), DATA.Rarities.get(rarity), key).Name, " : ", collection[ID][rarity][key])
	print("\n")
