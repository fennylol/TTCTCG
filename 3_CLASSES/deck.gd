class_name Deck

var Name: String = "New Deck"

var Critters: Array[PlayablePair] = []
var Consumables: Array[PlayablePair] = []
var Weapons: Array[PlayablePair] = []
var WildCards: Array[PlayablePair] = []

static func parse_deck_list(_Dict: Dictionary) -> Array[Deck]:
	
	return []

static func parse_single_deck(_Dict: Dictionary) -> Deck:
	return Deck.new()

func to_dict() -> Dictionary:
	var dict = {}
	
	var critters: Array[Dictionary] = []
	for card in Critters:
		critters.append(card.to_dict())
	dict["critters"] = critters
	
	var consumables: Array[Dictionary] = []
	for card in Consumables:
		consumables.append(card.to_dict())
	dict["consumables"] = consumables
	
	var weapons: Array[Dictionary] = []
	for card in Weapons:
		weapons.append(card.to_dict())
	dict["weapons"] = weapons
	
	var wildcards: Array[Dictionary] = []
	for card in WildCards:
		wildcards.append(card.to_dict())
	dict["wildcards"] = wildcards
	
	return dict

func add_to_deck(pair: PlayablePair):
	var target: Array[PlayablePair] = WildCards
	match pair.PairedType:
		DATA.ContentTypes.CRITTER:
			target = Critters
		DATA.ContentTypes.CONSUMABLE:
			target = Consumables
		DATA.ContentTypes.WEAPON:
			target = Weapons
	
	if target.size() < 5:
		target.append(pair)
	elif WildCards.size() < 5:
		WildCards.append(pair)
	else:
		print("deck is full")
