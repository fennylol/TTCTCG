class_name DATA
## a unified resources for storing and accessing expansion, pack, and content data


## the rarities for both packs and pack contents
enum Rarities                    {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY, HOLY_MOLY}
## the internal IDs for each expansion
enum ExpansionIDs                {GASTROARCHEOLOGY, INCHEFTION}
## the fields of [member ExpansionContent]
enum ExpansionContentFields      {NAME, IMAGE, STATS}
enum CritterDescriptionFields    {FLAVOR, HEALTH, DAMAGE, SPEED, EYESIGHT, HEARING, NATURE}
enum CritterNatures              {NORMAL, BRAVE, SKITTISH, HUNGRY, HELPFUL, VENGEFUL}
enum ConsumableDescriptionFields {FLAVOR, RANGE, DAMAGE, AOE, TARGET}
enum WeaponDescriptionFields     {FLAVOR, RANGE, DAMAGE, AMMO, ACCURACY, FIRERATE, TARGET}
enum Targets                     {ENEMY, ALLY, TERRAIN, EVERYONELOL}
## the types of content. 
enum ContentTypes                {CRITTER, CONSUMABLE, WEAPON}
enum ContentSides                {TAKER, BAKER}

enum Probabilities {ORIGINAL, MOD_RARE, CURRENT_IDEAL, BRUTAL}
enum ProbabilityCurveFields         {PACK_RARITY_ODDS, CONTENT_RARITY_ODDS, PACK_RARITY_CONTENT_COUNTS}
const ProbabilityCurves: Dictionary = {
	Probabilities.ORIGINAL : {
		DATA.ProbabilityCurveFields.PACK_RARITY_ODDS : [0.564, 0.248, 0.109, 0.048, 0.021, 0.010], # exponential, B=0.44
		DATA.ProbabilityCurveFields.CONTENT_RARITY_ODDS : [
			[0.389, 0.278, 0.179, 0.100, 0.044, 0.010], # beta, A=1.05, S=2
			[0.275, 0.277, 0.220, 0.142, 0.069, 0.017], # beta, A=1.55, S=2
			[0.180, 0.257, 0.249, 0.186, 0.101, 0.027], # beta, A=2.05, S=2
			[0.110, 0.221, 0.263, 0.227, 0.138, 0.041], # beta, A=2.55, S=2
			[0.063, 0.180, 0.261, 0.261, 0.177, 0.058], # beta, A=3.05, S=2
			[0.035, 0.139, 0.247, 0.285, 0.216, 0.078]  # beta, A=3.55, S=2
		],
		DATA.ProbabilityCurveFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
	},
	Probabilities.MOD_RARE : {
		DATA.ProbabilityCurveFields.PACK_RARITY_ODDS : [0.564, 0.248, 0.109, 0.048, 0.021, 0.010], # exponential, B=0.44
		DATA.ProbabilityCurveFields.CONTENT_RARITY_ODDS : [
			[0.357, 0.341, 0.202, 0.080, 0.018, 0.002], # beta, A=2.05, S=4.25
			[0.287, 0.344, 0.235, 0.105, 0.026, 0.003], # beta, A=2.35, S=4.15
			[0.224, 0.336, 0.266, 0.133, 0.037, 0.004], # beta, A=2.65, S=4.05
			[0.170, 0.319, 0.291, 0.164, 0.051, 0.005], # beta, A=2.95, S=3.95
			[0.125, 0.294, 0.310, 0.196, 0.068, 0.007], # beta, A=3.25, S=3.85
			[0.090, 0.264, 0.321, 0.227, 0.088, 0.010]  # beta, A=3.55, S=3.75
		],
		DATA.ProbabilityCurveFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
	},
	Probabilities.CURRENT_IDEAL : {
		DATA.ProbabilityCurveFields.PACK_RARITY_ODDS : [0.564, 0.248, 0.109, 0.048, 0.021, 0.010], # exponential, B=0.44
		DATA.ProbabilityCurveFields.CONTENT_RARITY_ODDS : [
			[0.4528, 0.3157, 0.1600, 0.0583, 0.0125, 0.0007], # beta, A=1.53, S=3.92, N=7.9
			[0.4058, 0.3272, 0.1805, 0.0699, 0.0157, 0.0009], # beta, A=1.74, S=3.92, N=7.9
			[0.3595, 0.3354, 0.2015, 0.0829, 0.0195, 0.0012], # beta, A=1.95, S=3.92, N=7.9
			[0.3150, 0.3400, 0.2223, 0.0972, 0.0240, 0.0015], # beta, A=2.16, S=3.92, N=7.9
			[0.2730, 0.3406, 0.2426, 0.1127, 0.0291, 0.0020], # beta, A=2.37, S=3.92, N=7.9
			[0.2339, 0.3376, 0.2619, 0.1291, 0.0350, 0.0025]  # beta, A=2.58, S=3.92, N=7.9
		],
		DATA.ProbabilityCurveFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
	},
	Probabilities.BRUTAL : {
		DATA.ProbabilityCurveFields.PACK_RARITY_ODDS : [0.564, 0.248, 0.109, 0.048, 0.021, 0.010], # exponential, B=0.44
		DATA.ProbabilityCurveFields.CONTENT_RARITY_ODDS : [
			[0.4251, 0.3195, 0.1743, 0.0671, 0.0137, 0.0003], # beta, A=1.53, S=3.2, N=7.42
			[0.3782, 0.3290, 0.1954, 0.0171, 0.0799, 0.0004], # beta, A=1.74, S=3.2, N=7.42
			[0.3329, 0.3348, 0.2166, 0.0941, 0.0211, 0.0005], # beta, A=1.95, S=3.2, N=7.42
			[0.2897, 0.3370, 0.2374, 0.1095, 0.0258, 0.0006], # beta, A=2.16, S=3.2, N=7.42
			[0.2492, 0.3354, 0.2573, 0.1261, 0.0312, 0.0008], # beta, A=2.37, S=3.2, N=7.42
			[0.2122, 0.3303, 0.2758, 0.1436, 0.0371, 0.0010]  # beta, A=2.58, S=3.2, N=7.42
		],
		DATA.ProbabilityCurveFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
	}
}

## metadata about expansions. contains pack and content rarity and content count per pack.[br]
## see [member ExpansionContent] for pack contents. 
const ExpansionProbability: Dictionary = {
	ExpansionIDs.INCHEFTION       : ProbabilityCurves[Probabilities.CURRENT_IDEAL],
	ExpansionIDs.GASTROARCHEOLOGY : ProbabilityCurves[Probabilities.CURRENT_IDEAL]
}

## data store of content from each expansion. [br]
## for expansion statistics, see [member ExpansionProbability]
const ExpansionContent: Dictionary = {
	ExpansionIDs.INCHEFTION       : IncheftionData.EXPANSION_CONTENT,
	ExpansionIDs.GASTROARCHEOLOGY : GastroArcheologyData.EXPANSION_CONTENT
}

## [b]Purpose[/b]: gets the odds for each rarity of pack to be generated for a specific expansion [br]
## from [constant ExpansionProbability] [br]
## [b]ExpansionID[/b]: the expansion for the pack being generated. (See [enum ExpansionIDs])[br]
## [b]Returns[/b]: an array of floats, indexed by [enum Rarities] representing the odds for each rarity to be[br]
## pulled
static func get_pack_rarity_odds(ExpansionID : ExpansionIDs) -> Array[float]:
	var arr: Array[float] = Array(ExpansionProbability[ExpansionID][ProbabilityCurveFields.PACK_RARITY_ODDS], TYPE_FLOAT, "", null)
	assert(abs(array_sum(arr)-1.0) <= 0.001, "pack odds != 1, "+ str(array_sum(arr)))
	return arr

## [b]Purpose[/b]: gets the odds for each content in a specific rarity of pack to be generated for a[br]
## specific expansion from [constant ExpansionProbability][br]
## [b]ExpansionID[/b]: the expansion for the pack being generated. (See [enum ExpansionIDs])[br]
## [b]PackRarity[/b]: the rarity for the pack being generated. (see [enum Rarities])[br]
## [b]Returns[/b]: an array of floats, indexed by [enum Rarities] representing the odds for each rarity to be[br]
## pulled
static func get_content_rarity_odds(ExpansionID : ExpansionIDs, PackRarity : Rarities) -> Array[float]: 
	var arr: Array[float] = Array(ExpansionProbability[ExpansionID][ProbabilityCurveFields.CONTENT_RARITY_ODDS][PackRarity], TYPE_FLOAT, "", null)
	assert(abs(array_sum(arr)-1.0) <= 0.001, "pack content odds != 1, " + str(array_sum(arr)))
	return arr


## [b]Purpose[/b]: gets the number of content contained in a rarity of pack of an expansion[br] 
## [b]ExpansionID[/b]: the expansion being queried. (See [enum ExpansionIDs])[br]
## [b]PackRarity[/b]: the rarity of the pack being queried. (see [enum Rarities])[br]
static func get_pack_content_count(ExpansionID : ExpansionIDs, PackRarity : Rarities) -> int:
	return ExpansionProbability[ExpansionID][ProbabilityCurveFields.PACK_RARITY_CONTENT_COUNTS][PackRarity]


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
	var data : Dictionary = ExpansionContent[ExpansionID][ContentRarity][ContentType][ContentIndex]
	return Card.new(
			ExpansionID,
			ContentRarity,
			ContentType,
			ContentIndex,
			data[ExpansionContentFields.NAME],
			data[ExpansionContentFields.IMAGE]
		)
static func get_paired_expansion_content(ExpansionID : ExpansionIDs, ContentRarity : Rarities, ContentType : ContentTypes, ContentIndex : int, \
										 PairedExpansionID : ExpansionIDs, PairedRarity : Rarities, PairedIndex  : int) -> PlayablePair:
	var data        : Dictionary = ExpansionContent[ExpansionID][ContentRarity][ContentType][ContentIndex]
	var paired_data : Dictionary = ExpansionContent[ExpansionID][PairedRarity][ContentType][PairedIndex]
	return PlayablePair.new(
		ExpansionID,
		ContentRarity,
		ContentType,
		ContentIndex,
		data[ExpansionContentFields.NAME],
		data[ExpansionContentFields.IMAGE],
		
		PairedExpansionID,
		PairedRarity,
		PairedIndex,
		paired_data[ExpansionContentFields.NAME],
		paired_data[ExpansionContentFields.IMAGE]
	)
static func get_content_stats(ExpansionID : ExpansionIDs, ContentRarity : Rarities, ContentType : ContentTypes, ContentIndex : int) -> Dictionary:
	return ExpansionContent[ExpansionID][ContentRarity][ContentType][ContentIndex][ExpansionContentFields.STATS]


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
	var mat_name: String = Rarities.find_key(rarity)+"_flat" if rarity != 6 else "disabled_flat"
	if not THEBANK._check_material(mat_name): 
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
		THEBANK._check_in_material(mat_name, material)
	return THEBANK._check_out_material(mat_name)

static func create_rarity_shader_material(rarity: Rarities, texture_seed: int) -> ShaderMaterial:
	var mat_name: String = Rarities.find_key(rarity)+"_shaded"
	if not THEBANK._check_material(mat_name): 
		var color: Color = get_color_from_rarity(rarity)
		var img_size: int = 64
		var image = Image.create(img_size, img_size, false, Image.FORMAT_RGB8)
		
		for y in range(img_size): 
			for x in range(img_size):
				image.set_pixel(x, y, color)
		
		var texture = ImageTexture.new()
		texture.set_image(image)
		
		var noise_texture := NoiseTexture2D.new()
		var noise := FastNoiseLite.new()
		noise.set_seed(texture_seed)
		noise.set_noise_type(FastNoiseLite.TYPE_PERLIN)
		noise.set_frequency(0.05)
		noise.set_fractal_type(FastNoiseLite.FRACTAL_PING_PONG)
		noise.set_fractal_octaves(1)
		noise_texture.set_seamless(true)
		noise_texture.set_noise(noise)
		
		var material = ShaderMaterial.new()
		material.shader = load("res://1_ASSETS/cards/holographic.gdshader")
		material.set_shader_parameter("texture_albedo", texture)
		material.set_shader_parameter("texture_noise", noise_texture)
		THEBANK._check_in_material(mat_name, material)
	return THEBANK._check_out_material(mat_name)

static func create_paired_rarity_material(front_rarity: Rarities, back_rarity: Rarities) -> StandardMaterial3D:
	var mat_name: String = Rarities.find_key(front_rarity)+"_"+Rarities.find_key(back_rarity)+"_flat"
	if not THEBANK._check_material(mat_name): 
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
		THEBANK._check_in_material(mat_name, material)
	return THEBANK._check_out_material(mat_name)

static func create_paired_rarity_shader_material(front_rarity: Rarities, back_rarity: Rarities, texture_seed: int) -> ShaderMaterial:
	var mat_name: String = Rarities.find_key(front_rarity)+"_"+Rarities.find_key(back_rarity)+"_shaded"
	if not THEBANK._check_material(mat_name): 
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
		
		var noise_texture := NoiseTexture2D.new()
		var noise := FastNoiseLite.new()
		noise.set_seed(texture_seed)
		noise.set_noise_type(FastNoiseLite.TYPE_PERLIN)
		noise.set_frequency(0.05)
		noise.set_fractal_type(FastNoiseLite.FRACTAL_PING_PONG)
		noise.set_fractal_octaves(1)
		noise_texture.set_seamless(true)
		noise_texture.set_noise(noise)
		
		var material = ShaderMaterial.new()
		material.shader = load("res://1_ASSETS/cards/shaders/holographic.gdshader")
		material.set_shader_parameter("texture_albedo", texture)
		material.set_shader_parameter("texture_noise", noise_texture)
		
		THEBANK._check_in_material(mat_name, material)
	return THEBANK._check_out_material(mat_name)

static func create_sprite_shader_material(texture : Texture, texture_seed: int) -> ShaderMaterial:
	var mat_name: String = texture.resource_path+"_shaded"
	if not THEBANK._check_material(mat_name): 
		var noise_texture := NoiseTexture2D.new()
		var noise := FastNoiseLite.new()
		noise.set_seed(texture_seed)
		noise.set_noise_type(FastNoiseLite.TYPE_PERLIN)
		noise.set_frequency(0.025)
		noise.set_fractal_type(FastNoiseLite.FRACTAL_PING_PONG)
		noise.set_fractal_octaves(1)
		noise_texture.set_seamless(true)
		noise_texture.set_noise(noise)
		
		var material = ShaderMaterial.new()
		material.shader = load("res://1_ASSETS/cards/shaders/holographic.gdshader")
		material.set_shader_parameter("texture_albedo", texture)
		material.set_shader_parameter("texture_noise", noise_texture)
		THEBANK._check_in_material(mat_name, material)
	return THEBANK._check_out_material(mat_name)

static func DEBUG_print_prob_curve_EVs(curve_type: Probabilities) -> void:
	var expected_values := DEBUG_test_probability_curve(curve_type)
	
	LOGGER.log_msg("The average pack from " + Probabilities.find_key(curve_type) + " will contain:")
	for rarity in Rarities:
		var r = Rarities[rarity]
		var Str: String = "├─ " if r != Rarities.HOLY_MOLY else "╰─ "
		LOGGER.log_msg(Str + str(expected_values[r]) + " " + rarity + " cards")
	LOGGER.log_msg("and an average of " + str(array_sum(expected_values)) + " total cards.\n")

static func DEBUG_test_probability_curve(curve_type: Probabilities) -> Array[float]:
	var expected_values: Array[float] = [0, 0, 0, 0, 0, 0]
	for pack_tier in range(Rarities.size()):
		var pack_probability = ProbabilityCurves[curve_type][ProbabilityCurveFields.PACK_RARITY_ODDS][pack_tier]
		var pack_card_count = ProbabilityCurves[curve_type][ProbabilityCurveFields.PACK_RARITY_CONTENT_COUNTS][pack_tier]
		for card_tier in range(Rarities.size()):
			var card_probability = ProbabilityCurves[curve_type][ProbabilityCurveFields.CONTENT_RARITY_ODDS][pack_tier][card_tier]
			expected_values[card_tier] += pack_probability * pack_card_count * card_probability
	return expected_values

static func DEBUG_print_expansion_EVs(ExpansionID : ExpansionIDs) -> void:
	var expected_values := get_expansion_EVs(ExpansionID)
	
	LOGGER.log_msg("The average pack from " + ExpansionIDs.find_key(ExpansionID) + " will contain:")
	for rarity in Rarities:
		var r = Rarities[rarity]
		var Str: String = "├─ " if r != Rarities.HOLY_MOLY else "╰─ "
		LOGGER.log_msg(Str + str(expected_values[r]) + " " + rarity + " cards")
	LOGGER.log_msg("and an average of " + str(array_sum(expected_values)) + " total cards.\n")

static func get_expansion_EVs(ExpansionID : ExpansionIDs) -> Array[float]:
	var expected_values: Array[float] = [0, 0, 0, 0, 0, 0]
	for pack_tier in range(Rarities.size()):
		var pack_probability = ExpansionProbability[ExpansionID][ProbabilityCurveFields.PACK_RARITY_ODDS][pack_tier]
		var pack_card_count = ExpansionProbability[ExpansionID][ProbabilityCurveFields.PACK_RARITY_CONTENT_COUNTS][pack_tier]
		for card_tier in range(Rarities.size()):
			var card_probability = ExpansionProbability[ExpansionID][ProbabilityCurveFields.CONTENT_RARITY_ODDS][pack_tier][card_tier]
			expected_values[card_tier] += pack_probability * pack_card_count * card_probability
	return expected_values
	

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
