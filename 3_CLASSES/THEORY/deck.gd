class_name Deck

var Name: String = "New Deck"
var Critters: Array[Dictionary] = []
var Consumables: Array[Dictionary] = []
var Weapons: Array[Dictionary] = []
var WildCards: Array[Dictionary] = []

enum DictFields {NAME, CRITTERS, CONSUMABLES, WEAPONS, WILDCARDS}

static func restore_from_dict(Dict: Dictionary) -> Deck:
	assert(dict_is_deck(Dict, true), "deck.gd - restore_from_dict(): Dict is not a Deck")
	var parsed_deck = Deck.new()
	parsed_deck.Name        = Dict[DictFields.NAME]
	parsed_deck.Critters    = Dict[DictFields.CRITTERS]
	parsed_deck.Consumables = Dict[DictFields.CONSUMABLES]
	parsed_deck.Weapons     = Dict[DictFields.WEAPONS]
	parsed_deck.WildCards   = Dict[DictFields.WILDCARDS]
	return parsed_deck
func reduce_to_dict() -> Dictionary:
	var dict = {}
	dict[DictFields.NAME]        = Name
	dict[DictFields.CRITTERS]    = Critters
	dict[DictFields.CONSUMABLES] = Consumables
	dict[DictFields.WEAPONS]     = Weapons
	dict[DictFields.WILDCARDS]   = WildCards
	return dict
static func dict_is_deck(Dict: Dictionary, LogResult: bool = false) -> bool:
	if not Dict.keys().has(DictFields.NAME): 
		if LogResult: LOGGER.log_msg("deck.gd - dict_is_deck(): Dict is not a deck, no NAME",    LOGGER.Flags.WARN)
		return false
	if not Dict.keys().has(DictFields.CRITTERS): 
		if LogResult: LOGGER.log_msg("deck.gd - dict_is_deck(): Dict is not a deck, no CRITTERS",    LOGGER.Flags.WARN)
		return false
	if not Dict.keys().has(DictFields.CONSUMABLES): 
		if LogResult: LOGGER.log_msg("deck.gd - dict_is_deck(): Dict is not a deck, no CONSUMABLES", LOGGER.Flags.WARN)
		return false
	if not Dict.keys().has(DictFields.WEAPONS): 
		if LogResult: LOGGER.log_msg("deck.gd - dict_is_deck(): Dict is not a deck, no WEAPONS",     LOGGER.Flags.WARN)
		return false
	if not Dict.keys().has(DictFields.WILDCARDS): 
		if LogResult: LOGGER.log_msg("deck.gd - dict_is_deck(): Dict is not a deck, no WILDCARDS",   LOGGER.Flags.WARN)
		return false
	return true

func add_to_deck(pair: Dictionary):
	assert(PlayablePair.dict_is_playable_pair(pair, true), "deck.gd - add_to_deck(): Dict is not a PlayablePair")
	
	var target: Array[Dictionary] = WildCards
	match pair["FRONT"][Card.DictFields.TYPE]:
		DATA.ContentTypes.CRITTER:    target = Critters
		DATA.ContentTypes.CONSUMABLE: target = Consumables
		DATA.ContentTypes.WEAPON:     target = Weapons
	
	if target.size() < 5: target.append(pair)
	elif WildCards.size() < 5: WildCards.append(pair)
	else: LOGGER.log_msg("deck.gd: deck is full", LOGGER.Flags.ERR_STDOUT)

func remove_from_deck(pair: Dictionary):
	var target: Array[Dictionary] = WildCards
	match pair["FRONT"][Card.DictFields.TYPE]:
		DATA.ContentTypes.CRITTER:    target = Critters
		DATA.ContentTypes.CONSUMABLE: target = Consumables
		DATA.ContentTypes.WEAPON:     target = Weapons
	
	if target.has(pair): target.erase(pair)

#func _notification(what: int) -> void: 
	#if what == NOTIFICATION_PREDELETE:
		#for card in Critters: card.queue_free()
		#for card in Consumables: card.queue_free()
		#for card in Weapons: card.queue_free()
		#for card in WildCards: card.queue_free()
