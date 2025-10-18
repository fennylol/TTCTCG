class_name DATA
## a unified resources for storing and accessing expansion, pack, and content data


## the rarities for both packs and pack contents
enum Rarities {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY, HOLY_MOLY}
## the internal IDs for each expansion
enum ExpansionIDs {TEST_SET, OTHER_SET}
## the fields of [member ExpansionData] 
enum ExpansionDataFields {PACK_RARITY_ODDS, CONTENT_RARITY_ODDS, PACK_RARITY_CONTENT_COUNTS}
## the fields of [member ExpansionContent]
enum ExpansionContentFields {NAME, TYPE, IMAGE}
## the types of content. 
enum ContentTypes {CRITTER, CONSUMABLE, WEAPON}
enum ContentSides {ATK, DEF}


#ExpansionIDs.TEST_SET : {
	#ExpansionDataFields.PACK_RARITY_ODDS : [0.5, 0.28, 0.15, 0.05, 0.015, 0.005],
	#ExpansionDataFields.CONTENT_RARITY_ODDS : [
		#[0.5, 0.28, 0.15, 0.05, 0.015, 0.005],
		#[0.4, 0.38, 0.15, 0.05, 0.015, 0.005],
		#[0.3, 0.28, 0.35, 0.05, 0.015, 0.005],
		#[0.2, 0.28, 0.15, 0.35, 0.015, 0.005],
		#[0.1, 0.28, 0.15, 0.05, 0.415, 0.005],
		#[0.0, 0.28, 0.15, 0.05, 0.015, 0.505]
	#],
	#ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
#}
## metadata about expansions. contains pack and content rarity and content count per pack.[br]
## see [member ExpansionContent] for pack contents. 
const ExpansionData: Dictionary = {
	ExpansionIDs.TEST_SET : {
		ExpansionDataFields.PACK_RARITY_ODDS : [0.564, 0.248, 0.109, 0.048, 0.021, 0.010], # exponential, B=0.44
		ExpansionDataFields.CONTENT_RARITY_ODDS : [
			[0.389, 0.278, 0.179, 0.100, 0.044, 0.010], # beta, A=1.05, S=2
			[0.275, 0.277, 0.220, 0.142, 0.069, 0.017], # beta, A=1.55, S=2
			[0.180, 0.257, 0.249, 0.186, 0.101, 0.027], # beta, A=2.05, S=2
			[0.110, 0.221, 0.263, 0.227, 0.138, 0.041], # beta, A=2.55, S=2
			[0.063, 0.180, 0.261, 0.261, 0.177, 0.058], # beta, A=3.05, S=2
			[0.035, 0.139, 0.247, 0.285, 0.216, 0.078]  # beta, A=3.55, S=2
		],
		ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
	},
	ExpansionIDs.OTHER_SET : {
		ExpansionDataFields.PACK_RARITY_ODDS : [0.564, 0.248, 0.109, 0.048, 0.021, 0.010], # exponential, B=0.44
		ExpansionDataFields.CONTENT_RARITY_ODDS : [
			[0.389, 0.278, 0.179, 0.100, 0.044, 0.010], # beta, A=1.05, S=2
			[0.275, 0.277, 0.220, 0.142, 0.069, 0.017], # beta, A=1.55, S=2
			[0.180, 0.257, 0.249, 0.186, 0.101, 0.027], # beta, A=2.05, S=2
			[0.110, 0.221, 0.263, 0.227, 0.138, 0.041], # beta, A=2.55, S=2
			[0.063, 0.180, 0.261, 0.261, 0.177, 0.058], # beta, A=3.05, S=2
			[0.035, 0.139, 0.247, 0.285, 0.216, 0.078]  # beta, A=3.55, S=2
		],
		ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
	}
	#ExpansionIDs.TEST_SET : {
		#ExpansionDataFields.PACK_RARITY_ODDS : [],
		#ExpansionDataFields.CONTENT_RARITY_ODDS : [[],[],[],[],[],[]],
		#ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS : []
	#},
}

## data store of content from each expansion. [br]
## for expansion statistics, see [member ExpansionData]
const ExpansionContent: Dictionary = {
	ExpansionIDs.TEST_SET : {
		Rarities.COMMON : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Glormpus The Great Frog", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/0_Common/TEST_SET/GlormpusTheGreatFrog.png",
				},
				{
					ExpansionContentFields.NAME : "Rat", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/0_Common/TEST_SET/Rat.png",
				},
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Regular Ol' Cigarette", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/0_Common/TEST_SET/RegularCigarette.png",
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Baseball Bat", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/0_Common/TEST_SET/BaseballBat.png",
				}
			]
		},
		
		Rarities.UNCOMMON : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Greg", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/1_Uncommon/TEST_SET/Greg.png",
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Menthol Cigarette", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/1_Uncommon/TEST_SET/MentholCigarette.png",
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Body Spray", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/1_Uncommon/TEST_SET/BodySpray.png",
				}
			]
		},
		
		Rarities.RARE : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "The Weird Fish", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/2_Rare/TEST_SET/Weird_Fish.png",
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Reliable Grenade", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/2_Rare/TEST_SET/ReliableGrenade.png",
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Zipper Lighter", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/2_Rare/TEST_SET/ZipperLighter.png",
				}
			]
		},
		
		Rarities.EPIC : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "The Weirder Fish", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/3_Epic/TEST_SET/Weirder_Fish.png",
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Molotov Mocktail", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/3_Epic/TEST_SET/MolotovMocktail.png",
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Blood Blade", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/3_Epic/TEST_SET/BloodKnife.png",
				}
			]
		},
		
		Rarities.LEGENDARY : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Birb", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/4_Legendary/TEST_SET/Birb.png",
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Lump of Mold", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/4_Legendary/TEST_SET/PileOfMold.png",
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Shrank Ray", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/4_Legendary/TEST_SET/ShrankRay.png",
				}
			]
		},
		
		Rarities.HOLY_MOLY : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "The Man of Mud", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/5_Holy_Moly/TEST_SET/The_Man_of_Mud.png",
				},
				{
					ExpansionContentFields.NAME : "Snel", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/5_Holy_Moly/TEST_SET/Snel.png",
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Chicken Nugget Dipped in Mystery Sauce", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/5_Holy_Moly/TEST_SET/ChickenNuggetInMysterySauce.png",
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Stank Ray", 
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/5_Holy_Moly/TEST_SET/StankRay.png",
				}
			]
		}, 
	},
	ExpansionIDs.OTHER_SET : {
		Rarities.COMMON : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Gumbus Dragon",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/0_Common/OTHER_SET/gumbus_dragon.png"
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Calming Flower",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/0_Common/OTHER_SET/calming_flower.png"
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Plain Knife",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/0_Common/OTHER_SET/plain_knife.png"
				}
			]
		},
		Rarities.UNCOMMON : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Brootiss",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/1_Uncommon/OTHER_SET/brutiss.png"
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Rock Candy",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/1_Uncommon/OTHER_SET/rock_candy.png"
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Reapers Scythe",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/1_Uncommon/OTHER_SET/reapers_scythe.png"
				}
			]
		},
		Rarities.RARE : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Stoomp",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/2_Rare/OTHER_SET/stoomp.png"
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Pile of Inordinate Wealth",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/2_Rare/OTHER_SET/pile_of_inordinate_wealth.png"
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Burning Blade",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/2_Rare/OTHER_SET/burning_blade.png"
				}
			]
		},
		Rarities.EPIC : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Fat FLjck",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/3_Epic/OTHER_SET/fat_fLjck.png"
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Gents Glove",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/3_Epic/OTHER_SET/gents_glove.png"
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Liars Dice",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/3_Epic/OTHER_SET/liars_dice.png"
				}
			]
		},
		Rarities.LEGENDARY : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Gribble",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/4_Legendary/OTHER_SET/squee.png"
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Flask of Tears",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/4_Legendary/OTHER_SET/flask_of_tears.png"
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Tome of Curses",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/4_Legendary/OTHER_SET/tome_of_curses.png"
				}
			]
		},
		Rarities.HOLY_MOLY : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Squee",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/5_Holy_Moly/OTHER_SET/gribble.png"
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Flask of Beers",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/5_Holy_Moly/OTHER_SET/flask_of_beers.png"
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "im not even kidding this staff is way too strong for you",
					ExpansionContentFields.IMAGE : "res://1_ASSETS/cards/art/5_Holy_Moly/OTHER_SET/im_not_even_kidding_this_staff_is_way_too_strong_for_you.png"
				}
			]
		}
	},
	#ExpansionIDs.OTHER_SET : {
		#Rarities.COMMON : {
			#ContentTypes.CRITTER : [{}],
			#ContentTypes.CONSUMABLE : [{}],
			#ContentTypes.WEAPON : [{}]
		#},
		#Rarities.UNCOMMON : {
			#ContentTypes.CRITTER : [{}],
			#ContentTypes.CONSUMABLE : [{}],
			#ContentTypes.WEAPON : [{}]
		#},
		#Rarities.RARE : {
			#ContentTypes.CRITTER : [{}],
			#ContentTypes.CONSUMABLE : [{}],
			#ContentTypes.WEAPON : [{}]
		#},
		#Rarities.EPIC : {
			#ContentTypes.CRITTER : [{}],
			#ContentTypes.CONSUMABLE : [{}],
			#ContentTypes.WEAPON : [{}]
		#},
		#Rarities.LEGENDARY : {
			#ContentTypes.CRITTER : [{}],
			#ContentTypes.CONSUMABLE : [{}],
			#ContentTypes.WEAPON : [{}]
		#},
		#Rarities.HOLY_MOLY : {
			#ContentTypes.CRITTER : [{}],
			#ContentTypes.CONSUMABLE : [{}],
			#ContentTypes.WEAPON : [{}]
		#}
	#}
}

## [b]Purpose[/b]: gets the odds for each rarity of pack to be generated for a specific expansion [br]
## from [constant ExpansionData] [br]
## [b]ExpansionID[/b]: the expansion for the pack being generated. (See [enum ExpansionIDs])[br]
## [b]Returns[/b]: an array of floats, indexed by [enum Rarities] representing the odds for each rarity to be[br]
## pulled
static func get_pack_rarity_odds(ExpansionID : ExpansionIDs) -> Array[float]:
	var arr: Array[float] = Array(ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_ODDS], TYPE_FLOAT, "", null)
	assert(abs(array_sum(arr)-1.0) <= 0.001, "pack odds != 1, "+ str(array_sum(arr)))
	return arr

## [b]Purpose[/b]: gets the odds for each content in a specific rarity of pack to be generated for a[br]
## specific expansion from [constant ExpansionData][br]
## [b]ExpansionID[/b]: the expansion for the pack being generated. (See [enum ExpansionIDs])[br]
## [b]PackRarity[/b]: the rarity for the pack being generated. (see [enum Rarities])[br]
## [b]Returns[/b]: an array of floats, indexed by [enum Rarities] representing the odds for each rarity to be[br]
## pulled
static func get_content_rarity_odds(ExpansionID : ExpansionIDs, PackRarity : Rarities) -> Array[float]: 
	var arr: Array[float] = Array(ExpansionData[ExpansionID][ExpansionDataFields.CONTENT_RARITY_ODDS][PackRarity], TYPE_FLOAT, "", null)
	assert(abs(array_sum(arr)-1.0) <= 0.001, "pack content odds != 1, " + str(array_sum(arr)))
	return arr


## [b]Purpose[/b]: gets the number of content contained in a rarity of pack of an expansion[br] 
## [b]ExpansionID[/b]: the expansion being queried. (See [enum ExpansionIDs])[br]
## [b]PackRarity[/b]: the rarity of the pack being queried. (see [enum Rarities])[br]
static func get_pack_content_count(ExpansionID : ExpansionIDs, PackRarity : Rarities) -> int:
	return ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS][PackRarity]


## [b]Purpose[/b]: gets the number of content contained in an expansion of a specified rarity[br] 
## [b]ExpansionID[/b]: the expansion being queried. (See [enum ExpansionIDs])[br]
## [b]ContentRarity[/b]: the rarity being queried. (see [enum Rarities])[br]
static func get_expansion_content_count(ExpansionID : ExpansionIDs, ContentRarity : Rarities, ContentType : ContentTypes) -> int:
	return ExpansionContent[ExpansionID][ContentRarity][ContentType].size()


## [b]Purpose[/b]: gets the data for a specified content from an expansion[br] 
## [b]ExpansionID[/b]: the expansion of the content being requested. (See [enum ExpansionIDs])[br]
## [b]ContentRarity[/b]: the rarity of the content being requested. (see [enum Rarities])[br]
## [b]ContentIndex[/b]: the index of the content being requested. (see [method get_expansion_content_count])
static func get_expansion_content(ExpansionID : ExpansionIDs, ContentRarity : Rarities, ContentType : ContentTypes, ContentIndex : int) -> Card:
	#return ExpansionContent[ExpansionID][ContentRarity][ContentIndex]
	var data : Dictionary = ExpansionContent[ExpansionID][ContentRarity][ContentType][ContentIndex]
	var c : Card 
	if ContentRarity < Rarities.EPIC:
		c = Card.new(
			ContentIndex,
			ExpansionID,
			data[ExpansionContentFields.NAME],
			ContentType,
			ContentRarity,
			load(data[ExpansionContentFields.IMAGE])
		)
	else:
		c = Card.new(
			ContentIndex,
			ExpansionID,
			data[ExpansionContentFields.NAME],
			ContentType,
			ContentRarity,
			load(data[ExpansionContentFields.IMAGE])
		) 
	return c


static func calculate_expected_card_proportions_per_pack(expansion_id: ExpansionIDs) -> Array[float]:
	var pack_rarity_odds = get_pack_rarity_odds(expansion_id)
	
	# Get the number of card rarities by checking the first pack's content rarity odds
	var num_rarities = get_content_rarity_odds(expansion_id, 0 as Rarities).size()
	var expected_cards_per_rarity: Array[float] = []
	
	# Initialize array with zeros
	for i in range(num_rarities):
		expected_cards_per_rarity.append(0.0)
	
	# For each pack rarity
	for pack_rarity_int in range(pack_rarity_odds.size()):
		var pack_rarity = pack_rarity_int as Rarities
		var pack_probability = pack_rarity_odds[pack_rarity_int]
		var cards_per_pack = get_pack_content_count(expansion_id, pack_rarity)
		var content_rarity_odds = get_content_rarity_odds(expansion_id, pack_rarity)
		
		# For each card rarity
		for card_rarity in range(num_rarities):
			var card_rarity_odds = content_rarity_odds[card_rarity]
			
			# Expected number of this rarity cards in this pack type
			var expected_cards_in_pack = cards_per_pack * card_rarity_odds
			
			# Weight by pack probability and add to total
			expected_cards_per_rarity[card_rarity] += pack_probability * expected_cards_in_pack
	
	# Calculate total expected cards per pack to convert to proportions
	var total_expected_cards = 0.0
	for expected_count in expected_cards_per_rarity:
		total_expected_cards += expected_count
	
	# Convert to proportions
	var proportions: Array[float] = []
	for expected_count in expected_cards_per_rarity:
		proportions.append(expected_count / total_expected_cards)
	
	return proportions

static func get_color_from_rarity(Rarity: Rarities) -> Color:
	const RARITY_COLOR_S : float = 0.75
	const RARITY_COLOR_L : float = 0.75
	var RarityColors: Array[Color]  =  [Color.from_ok_hsl(000.0/360.0,            0.0, RARITY_COLOR_L),
										Color.from_ok_hsl(140.0/360.0, RARITY_COLOR_S, RARITY_COLOR_L), 
										Color.from_ok_hsl(215.0/360.0, RARITY_COLOR_S, RARITY_COLOR_L),
										Color.from_ok_hsl(290.0/360.0, RARITY_COLOR_S, RARITY_COLOR_L),
										Color.from_ok_hsl(005.0/360.0, RARITY_COLOR_S, RARITY_COLOR_L),
										Color.from_ok_hsl(080.0/360.0, RARITY_COLOR_S, RARITY_COLOR_L),
										Color.from_ok_hsl(000.0/360.0,            0.0,            0.5)]
	return RarityColors[Rarity]

static func create_rarity_material(rarity: Rarities) -> StandardMaterial3D:
	var color: Color = get_color_from_rarity(rarity)
	var img_size: int = 64
	var image = Image.create(img_size, img_size, false, Image.FORMAT_RGB8)
	
	for y in range(img_size): 
		for x in range(img_size):
			image.set_pixel(x, y, color)
	
	var texture = ImageTexture.new()
	texture.set_image(image)
	
	var material = StandardMaterial3D.new()
	material.albedo_texture = texture
	
	return material

static func create_paired_rarity_material(front_rarity: Rarities, back_rarity: Rarities) -> StandardMaterial3D:
	var front_color: Color = get_color_from_rarity(front_rarity)
	var back_color: Color = get_color_from_rarity(back_rarity)
	var img_size: int = 64
	var image = Image.create(img_size, img_size, false, Image.FORMAT_RGB8)
	
	for y in range(img_size): 
		for x in range(img_size):
			if x < img_size/2: image.set_pixel(x, y, front_color)
			else: image.set_pixel(x, y, back_color)
	
	var texture = ImageTexture.new()
	texture.set_image(image)
	
	var material = StandardMaterial3D.new()
	material.albedo_texture = texture
	
	return material

static func DEBUG_print_expansion_EVs(ExpansionID : ExpansionIDs) -> void:
	var expected_values: Array[float] = [0, 0, 0, 0, 0, 0]
	
	for pack_tier in range(Rarities.size()):
		var pack_probability = ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_ODDS][pack_tier]
		var pack_card_count = ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS][pack_tier]
	
		for card_tier in range(Rarities.size()):
			var card_probability = ExpansionData[ExpansionID][ExpansionDataFields.CONTENT_RARITY_ODDS][pack_tier][card_tier]
			expected_values[card_tier] += pack_probability * pack_card_count * card_probability
	
	LOGGER.log_msg("The average pack from " + ExpansionIDs.find_key(ExpansionID) + " will contain:")
	for rarity in Rarities:
		var r = Rarities[rarity]
		var Str: String = "├─ " if r != Rarities.HOLY_MOLY else "╰─ "
		LOGGER.log_msg(Str + str(expected_values[r]) + " " + rarity + " cards")
	LOGGER.log_msg("and an average of " + str(array_sum(expected_values)) + " total cards.\n")


## [b]Purpose[/b]: sums all elements of an array of floats. Used for internal testing.[br]
## [b]Arr[/b]: an array of floats[br]
## [b]Returns[/b]: the sum 
static func array_sum(Arr: Array[float]) -> float:
	var sum: float = 0.0
	for f in Arr: sum+=f
	return sum

static func array_sum_i(Arr: Array[int]) -> int:
	var sum: int = 0
	for f in Arr: sum+=f
	return sum
