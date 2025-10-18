class_name Deck

var Name: String = "New Deck"
  
var Critters: Array[PlayablePair] = []
var Consumables: Array[PlayablePair] = []
var Weapons: Array[PlayablePair] = []
var WildCards: Array[PlayablePair] = []



static func parse_single_deck(Dict: Dictionary) -> Deck:
	assert(Dict["critters"] is Array[Dictionary])
	assert(Dict["consumables"] is Array[Dictionary])
	assert(Dict["weapons"] is Array[Dictionary])
	assert(Dict["wildcards"] is Array[Dictionary])
	
	var parsed_deck = Deck.new()
	var critters   : Array[Dictionary] = Dict["critters"]
	var consumables: Array[Dictionary] = Dict["consumables"]
	var weapons    : Array[Dictionary] = Dict["weapons"]
	var wildcards  : Array[Dictionary] = Dict["wildcards"]
	
	var parse_cards = func(dict: Array[Dictionary]): for pair in dict: parsed_deck.add_to_deck(PlayablePair.parse_dict(pair))
	parse_cards.call(critters)
	parse_cards.call(consumables)
	parse_cards.call(weapons)
	parse_cards.call(wildcards)
	
	return parsed_deck

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
		LOGGER.log_msg("deck.gd: deck is full", LOGGER.Flags.ERR_STDOUT)

func remove_from_deck(pair: PlayablePair):
	var target: Array[PlayablePair] = WildCards
	match pair.PairedType:
		DATA.ContentTypes.CRITTER:
			target = Critters
		DATA.ContentTypes.CONSUMABLE:
			target = Consumables
		DATA.ContentTypes.WEAPON:
			target = Weapons
	
	if target.has(pair): target.erase(pair)

func _notification(what: int) -> void: 
	if what == NOTIFICATION_PREDELETE:
		for card in Critters: card.queue_free()
		for card in Consumables: card.queue_free()
		for card in Weapons: card.queue_free()
		for card in WildCards: card.queue_free()
