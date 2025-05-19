extends Node3D

signal Results(ExpansionID : DATA.ExpansionIDs, CardList : Array)

const STARTING_PACK_HEIGHT: float = 5.0

func _ready() -> void:
	add_pack()

func add_pack():
	var pull: Dictionary = determine_pack_pull(DATA.ExpansionIDs.TEST_SET)
	var pack_rarity: DATA.Rarities = pull["RARITY"]
	var pack_content: Array[Card] = pull["CONTENT"]
	
	print("generated a ", DATA.Rarities.find_key(pack_rarity), " pack")
	
	var pack: Pack = Pack.new(pack_rarity, pack_content)
	pack.set_name(DATA.Rarities.find_key(pack_rarity).to_lower()+"_pack_"+str(int(RNG.random_value()*1000)))
	pack.position.y = STARTING_PACK_HEIGHT
	add_child(pack)
	pack.finished.connect(add_pack)


## [b]Purpose[/b]: generates a pack from a requested expansion[br]
## [b]ExpansionID[/b]: the expansion to generate a pack from. (see [enum DATA.ExpansionIDs])[br]
## [b]Returns[/b]: nothing. emits [signal Results] when completed.
func determine_pack_pull(ExpansionID : DATA.ExpansionIDs) -> Dictionary:
	var pack_rarity: DATA.Rarities = determine_pack_rarity(ExpansionID)
	var content_rarities: Array[DATA.Rarities] = determine_pack_content_rarities(ExpansionID, pack_rarity)
	var content: Array[Card] = determine_pack_contents(ExpansionID, content_rarities)
	return {"RARITY":pack_rarity, "CONTENT":content}

## [b]Purpose[/b]: determines the rarity for a pack from a requested expansion[br]
## [b]ExpansionID[/b]: the expansion to generate a pack from. (see [enum DATA.ExpansionIDs])[br]
## [b]Returns[/b]: a rarity. (see [enum DATA.Rarities])
func determine_pack_rarity(ExpansionID : DATA.ExpansionIDs) -> DATA.Rarities:
	var pack_rarity_odds: Array[float] = DATA.get_pack_rarity_odds(ExpansionID)
	var thresh = RNG.random_value()
	
	for r in DATA.Rarities:
		thresh -= pack_rarity_odds[DATA.Rarities[r]]
		if thresh <= 0: return DATA.Rarities[r]
	
	return -1


## [b]Purpose[/b]: determines the rarity for each content in a pack from a requested expansion[br]
## [b]ExpansionID[/b]: the expansion to generate a pack from. (see [enum DATA.ExpansionIDs])[br]
## [b]PackRarity[/b]: the rarity of pack to generate content for. (see [enum DATA.Rarities])[br]
## [b]Returns[/b]: an sorted array of rarities. (see [enum DATA.Rarities])
func determine_pack_content_rarities(ExpansionID : DATA.ExpansionIDs, PackRarity : DATA.Rarities) -> Array[DATA.Rarities]:
	var content_rarity_odds: Array[float] = DATA.get_content_rarity_odds(ExpansionID, PackRarity)
	var content_count: int = DATA.get_pack_content_count(ExpansionID, PackRarity)
	
	var rarities: Array[DATA.Rarities] = []
	for i in content_count:
		var thresh = RNG.random_value()
		for r in DATA.Rarities:
			thresh -= content_rarity_odds[DATA.Rarities[r]]
			if thresh <= 0: 
				rarities.append(DATA.Rarities[r])
				break
	
	rarities.sort()
	return rarities

func determine_pack_contents(ExpansionID : DATA.ExpansionIDs, ContentRarities : Array[DATA.Rarities]) -> Array[Card]:
	var cards: Array[Card] = []
	
	for rarity in ContentRarities:
		var idx: int = DATA.get_expansion_content_count(ExpansionID, rarity)
		idx = floor(idx * RNG.random_value())
		var card: Card = DATA.get_expansion_content(ExpansionID, rarity, idx)
		cards.append(card)
	
	return cards
