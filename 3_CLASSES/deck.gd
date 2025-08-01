class_name Deck

var Name: String = "New Deck"

var Critters: Array[PlayablePair] = Array()
var Consumables: Array[PlayablePair] = Array()
var Weapons: Array[PlayablePair] = Array()
var WildCards: Array[PlayablePair] = Array()

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
