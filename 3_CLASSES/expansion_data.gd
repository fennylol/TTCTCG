class_name DATA
## a unified resources for storing and accessing expansion, pack, and content data


## the rarities for both packs and pack contents
enum Rarities {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY, HOLY_MOLY}
## the internal IDs for each expansion
enum ExpansionIDs {TEST_SET}
## the fields of [member ExpansionData] 
enum ExpansionDataFields {PACK_RARITY_ODDS, CONTENT_RARITY_ODDS, PACK_RARITY_CONTENT_COUNTS}
## the fields of [member ExpansionContent]
enum ExpansionContentFields {NAME, TYPE, IMAGE}
## the types of content. 
enum ContentTypes {CRITTER, WEAPON, CONSUMABLE}

## metadata about expansions. contains pack and content rarity and content count per pack.[br]
## see [member ExpansionContent] for pack contents. 
const ExpansionData: Dictionary = {
	#ExpansionIDs.TEST_SET : {
		#ExpansionDataFields.PACK_RARITY_ODDS : [],
		#ExpansionDataFields.CONTENT_RARITY_ODDS : [[],[],[],[],[],[]],
		#ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS : []
	#},
	ExpansionIDs.TEST_SET : {
		ExpansionDataFields.PACK_RARITY_ODDS : [0.5, 0.28, 0.15, 0.05, 0.015, 0.005],
		ExpansionDataFields.CONTENT_RARITY_ODDS : [
			[0.5, 0.28, 0.15, 0.05, 0.015, 0.005],
			[0.4, 0.38, 0.15, 0.05, 0.015, 0.005],
			[0.3, 0.28, 0.35, 0.05, 0.015, 0.005],
			[0.2, 0.28, 0.15, 0.35, 0.015, 0.005],
			[0.1, 0.28, 0.15, 0.05, 0.415, 0.005],
			[0.0, 0.28, 0.15, 0.05, 0.015, 0.505]
		],
		ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
	}
}

## data store of content from each expansion. [br]
## for expansion statistics, see [member ExpansionData]
const ExpansionContent: Dictionary = {
	ExpansionIDs.TEST_SET : {
		Rarities.COMMON : [
			{
				ExpansionContentFields.NAME : "Glormpus The Great Frog", 
				ExpansionContentFields.TYPE : ContentTypes.CRITTER,
				ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/Art/0_Common/GlormpusTheGreatFrog.png",
			},
			{
				ExpansionContentFields.NAME : "Rat", 
				ExpansionContentFields.TYPE : ContentTypes.CRITTER,
				ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/Art/0_Common/Rat.png",
			},
		],
		Rarities.UNCOMMON : [
			{
				ExpansionContentFields.NAME : "Greg", 
				ExpansionContentFields.TYPE : ContentTypes.CRITTER,
				ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/Art/1_Uncommon/Greg.png",
			}
		],
		Rarities.RARE : [
			{
				ExpansionContentFields.NAME : "The Weird Fish", 
				ExpansionContentFields.TYPE : ContentTypes.CRITTER,
				ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/Art/2_Rare/Weird_Fish.png",
			}
		],
		Rarities.EPIC : [
			{
				ExpansionContentFields.NAME : "The Weirder Fish", 
				ExpansionContentFields.TYPE : ContentTypes.CRITTER,
				ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/Art/3_Epic/Weirder_Fish.png",
			}
		],
		Rarities.LEGENDARY : [
			{
				ExpansionContentFields.NAME : "Birb", 
				ExpansionContentFields.TYPE : ContentTypes.CRITTER,
				ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/Art/4_Legendary/Birb.png",
			}
		],
		Rarities.HOLY_MOLY : [
			{
				ExpansionContentFields.NAME : "The Man of Mud", 
				ExpansionContentFields.TYPE : ContentTypes.CRITTER,
				ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/Art/5_Holy_Moly/The_Man_of_Mud.png",
			},
			{
				ExpansionContentFields.NAME : "Snel", 
				ExpansionContentFields.TYPE : ContentTypes.CRITTER,
				ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/Art/5_Holy_Moly/Snel.png",
			}
		]
	}
}

## [b]Purpose[/b]: gets the odds for each rarity of pack to be generated for a specific expansion [br]
## from [constant ExpansionData] [br]
## [b]ExpansionID[/b]: the expansion for the pack being generated. (See [enum ExpansionIDs])[br]
## [b]Returns[/b]: an array of floats, indexed by [enum Rarities] representing the odds for each rarity to be[br]
## pulled
static func get_pack_rarity_odds(ExpansionID : ExpansionIDs) -> Array[float]:
	var arr: Array[float] = Array(ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_ODDS], TYPE_FLOAT, "", null)
	assert(array_sum(arr) == 1.0, "pack odds != 1")
	return arr

## [b]Purpose[/b]: gets the odds for each content in a specific rarity of pack to be generated for a[br]
## specific expansion from [constant ExpansionData][br]
## [b]ExpansionID[/b]: the expansion for the pack being generated. (See [enum ExpansionIDs])[br]
## [b]PackRarity[/b]: the rarity for the pack being generated. (see [enum Rarities])[br]
## [b]Returns[/b]: an array of floats, indexed by [enum Rarities] representing the odds for each rarity to be[br]
## pulled
static func get_content_rarity_odds(ExpansionID : ExpansionIDs, PackRarity : Rarities) -> Array[float]: 
	var arr: Array[float] = Array(ExpansionData[ExpansionID][ExpansionDataFields.CONTENT_RARITY_ODDS][PackRarity], TYPE_FLOAT, "", null)
	assert(array_sum(arr) == 1.0, "pack content odds != 1")
	return arr


## [b]Purpose[/b]: gets the number of content contained in a rarity of pack of an expansion[br] 
## [b]ExpansionID[/b]: the expansion being queried. (See [enum ExpansionIDs])[br]
## [b]PackRarity[/b]: the rarity of the pack being queried. (see [enum Rarities])[br]
static func get_pack_content_count(ExpansionID : ExpansionIDs, PackRarity : Rarities) -> int:
	return ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS][PackRarity]


## [b]Purpose[/b]: gets the number of content contained in an expansion of a specified rarity[br] 
## [b]ExpansionID[/b]: the expansion being queried. (See [enum ExpansionIDs])[br]
## [b]ContentRarity[/b]: the rarity being queried. (see [enum Rarities])[br]
static func get_expansion_content_count(ExpansionID : ExpansionIDs, ContentRarity : Rarities) -> int:
	return ExpansionContent[ExpansionID][ContentRarity].size()


## [b]Purpose[/b]: gets the data for a specified content from an expansion[br] 
## [b]ExpansionID[/b]: the expansion of the content being requested. (See [enum ExpansionIDs])[br]
## [b]ContentRarity[/b]: the rarity of the content being requested. (see [enum Rarities])[br]
## [b]ContentIndex[/b]: the index of the content being requested. (see [method get_expansion_content_count])
static func get_expansion_content(ExpansionID : ExpansionIDs, ContentRarity : Rarities, ContentIndex : int) -> Card:
	#return ExpansionContent[ExpansionID][ContentRarity][ContentIndex]
	var data : Dictionary = ExpansionContent[ExpansionID][ContentRarity][ContentIndex]
	var c : Card 
	if ContentRarity < Rarities.EPIC:
		c = Card.new(
			ContentIndex,
			data[ExpansionContentFields.NAME],
			data[ExpansionContentFields.TYPE],
			ContentRarity,
			load(data[ExpansionContentFields.IMAGE])
		)
	else:
		c = Card.new(
			ContentIndex,
			data[ExpansionContentFields.NAME],
			data[ExpansionContentFields.TYPE],
			ContentRarity,
			load(data[ExpansionContentFields.IMAGE])
		) 
	return c

static func DEBUG_print_expansion_EVs(ExpansionID : ExpansionIDs) -> void:
	var expected_values: Array[float] = [0, 0, 0, 0, 0, 0]
	
	for pack_tier in range(Rarities.size()):
		var pack_probability = ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_ODDS][pack_tier]
		var pack_card_count = ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS][pack_tier]
	
		for card_tier in range(Rarities.size()):
			var card_probability = ExpansionData[ExpansionID][ExpansionDataFields.CONTENT_RARITY_ODDS][pack_tier][card_tier]
			expected_values[card_tier] += pack_probability * pack_card_count * card_probability
	
	print("The average pack from ", ExpansionIDs.find_key(ExpansionID), " will contain:")
	for rarity in Rarities:
		var r = Rarities[rarity]
		var str: String = "├─ " if r != Rarities.HOLY_MOLY else "╰─ "
		print(str, expected_values[r], " ", rarity, " cards")
	print("and an average of ", array_sum(expected_values), " total cards.\n")


## [b]Purpose[/b]: sums all elements of an array of floats. Used for internal testing.[br]
## [b]Arr[/b]: an array of floats[br]
## [b]Returns[/b]: the sum 
static func array_sum(Arr: Array[float]) -> float:
	var sum: float = 0.0
	for f in Arr: sum+=f
	return sum
