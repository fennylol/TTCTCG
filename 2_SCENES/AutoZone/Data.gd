class_name DATA
## a unified resources for storing and accessing expansion, pack, and content data


## the rarities for both packs and pack contents
enum Rarities                    {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY, HOLY_MOLY}
## the internal IDs for each expansion
enum ExpansionIDs                {GASTROARCHEOLOGY, INCHEFTION}
## the fields of [member ExpansionData] 
enum ExpansionDataFields         {PACK_RARITY_ODDS, CONTENT_RARITY_ODDS, PACK_RARITY_CONTENT_COUNTS}
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

## metadata about expansions. contains pack and content rarity and content count per pack.[br]
## see [member ExpansionContent] for pack contents. 
const ExpansionData: Dictionary = {
	ExpansionIDs.INCHEFTION       : IncheftionData.EXPANSION_DATA,
	ExpansionIDs.GASTROARCHEOLOGY : GastroArcheologyData.EXPANSION_DATA
	#ExpansionIDs.TEST_SET : {
		#ExpansionDataFields.PACK_RARITY_ODDS : [],
		#ExpansionDataFields.CONTENT_RARITY_ODDS : [[],[],[],[],[],[]],
		#ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS : []
	#},
}

## data store of content from each expansion. [br]
## for expansion statistics, see [member ExpansionData]
const ExpansionContent: Dictionary = {
	ExpansionIDs.INCHEFTION       : IncheftionData.EXPANSION_CONTENT,
	ExpansionIDs.GASTROARCHEOLOGY : GastroArcheologyData.EXPANSION_CONTENT
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

#static func create_text_shader_material(texture_seed: int) -> ShaderMaterial:
	#var mat_name: String = "text_shaded"
	#if not THEBANK._check_material(mat_name): 
		#var noise_texture := NoiseTexture2D.new()
		#var noise := FastNoiseLite.new()
		#noise.set_seed(texture_seed)
		#noise.set_noise_type(FastNoiseLite.TYPE_PERLIN)
		#noise.set_frequency(0.025)
		#noise.set_fractal_type(FastNoiseLite.FRACTAL_PING_PONG)
		#noise.set_fractal_octaves(1)
		#noise_texture.set_seamless(true)
		#noise_texture.set_noise(noise)
		#
		#var material = ShaderMaterial.new()
		#material.shader = load("res://1_ASSETS/cards/holographic.gdshader")
		#material.set_shader_parameter("texture_noise", noise_texture)
		#THEBANK._check_in_material(mat_name, material)
	#return THEBANK._check_out_material(mat_name)

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
		var pack_probability = ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_ODDS][pack_tier]
		var pack_card_count = ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS][pack_tier]
		for card_tier in range(Rarities.size()):
			var card_probability = ExpansionData[ExpansionID][ExpansionDataFields.CONTENT_RARITY_ODDS][pack_tier][card_tier]
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
