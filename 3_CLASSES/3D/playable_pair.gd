extends Card
class_name  PlayablePair

var PairedExpansionID: DATA.ExpansionIDs
var PairedRarity: DATA.Rarities
var PairedIndex: int

var PairedName: String
var PairedImg: Texture2D
var PairedStats: Dictionary

var PairedSprite : Sprite3D

# ====================== #
# creation & destruction #
# ====================== #
func reduce_to_dict(Flipped : bool = false) -> Dictionary: 
	queue_free()
	return copy_to_dict(Flipped)
func copy_to_dict(Flipped : bool = false) -> Dictionary: 
	var front_dict := super.copy_to_dict()
	var back_dict := { 
			DictFields.EXPANSIONID  : PairedExpansionID,
			DictFields.RARITY       : PairedRarity, 
			DictFields.CONTENTINDEX : PairedIndex
		}
	if Flipped:
		back_dict[DictFields.TYPE] = front_dict.get(DictFields.TYPE)
		front_dict.erase(DictFields.TYPE)
	return { 
		"FRONT" : front_dict if not Flipped else back_dict,
		"BACK" : back_dict if not Flipped else front_dict
	}
static func restore_from_dict(Dict: Dictionary) -> PlayablePair: 
	assert(dict_is_playable_pair(Dict, true), "playable_pair.gd - restore_from_dict(): Dict is not a PlayablePair.")
	return DATA.get_paired_expansion_content(
		Dict["FRONT"][DictFields.EXPANSIONID],
		Dict["FRONT"][DictFields.RARITY],
		Dict["FRONT"][DictFields.TYPE],
		Dict["FRONT"][DictFields.CONTENTINDEX],
		Dict["BACK"][DictFields.EXPANSIONID],
		Dict["BACK"][DictFields.RARITY],
		Dict["BACK"][DictFields.CONTENTINDEX]
	)
static func create_from_two_cards(Front : Card, Back : Card) -> PlayablePair: 
	var front_dict := Front.reduce_to_dict()
	var back_dict := Back.reduce_to_dict()
	return DATA.get_paired_expansion_content(
		front_dict[DictFields.EXPANSIONID],
		front_dict[DictFields.RARITY],
		front_dict[DictFields.TYPE],
		front_dict[DictFields.CONTENTINDEX],
		back_dict[DictFields.EXPANSIONID],
		back_dict[DictFields.RARITY],
		back_dict[DictFields.CONTENTINDEX]
	)
static func dict_is_playable_pair(Dict: Dictionary, LogResult: bool = false) -> bool:
	if not Dict.keys().has("FRONT"):                          
		if LogResult: LOGGER.log_msg("playable_pair.gd - dict_is_playable_pair(): dict is not a PlayablePair, no FRONT",              LOGGER.Flags.WARN)
		return false
	if not Dict.keys().has("BACK"):                           
		if LogResult: LOGGER.log_msg("playable_pair.gd - dict_is_playable_pair(): dict is not a PlayablePair, no BACK",               LOGGER.Flags.WARN)
		return false
	if not Dict["FRONT"].keys().has(DictFields.EXPANSIONID):  
		if LogResult: LOGGER.log_msg("playable_pair.gd - dict_is_playable_pair(): dict is not a PlayablePair, no FRONT/EXPANSIONID",  LOGGER.Flags.WARN)
		return false
	if not Dict["FRONT"].keys().has(DictFields.RARITY):       
		if LogResult: LOGGER.log_msg("playable_pair.gd - dict_is_playable_pair(): dict is not a PlayablePair, no FRONT/RARITY",       LOGGER.Flags.WARN)
		return false
	if not Dict["FRONT"].keys().has(DictFields.TYPE):         
		if LogResult: LOGGER.log_msg("playable_pair.gd - dict_is_playable_pair(): dict is not a PlayablePair, no FRONT/TYPE",         LOGGER.Flags.WARN)
		return false
	if not Dict["FRONT"].keys().has(DictFields.CONTENTINDEX): 
		if LogResult: LOGGER.log_msg("playable_pair.gd - dict_is_playable_pair(): dict is not a PlayablePair, no FRONT/CONTENTINDEX", LOGGER.Flags.WARN)
		return false
	if not Dict["BACK"].keys().has(DictFields.EXPANSIONID):   
		if LogResult: LOGGER.log_msg("playable_pair.gd - dict_is_playable_pair(): dict is not a PlayablePair, no BACK/EXPANSIONID",   LOGGER.Flags.WARN)
		return false
	if not Dict["BACK"].keys().has(DictFields.RARITY):        
		if LogResult: LOGGER.log_msg("playable_pair.gd - dict_is_playable_pair(): dict is not a PlayablePair, no BACK/RARITY",        LOGGER.Flags.WARN)
		return false
	if not Dict["BACK"].keys().has(DictFields.CONTENTINDEX):  
		if LogResult: LOGGER.log_msg("playable_pair.gd - dict_is_playable_pair(): dict is not a PlayablePair, no BACK/CONTENTINDEX",  LOGGER.Flags.WARN)
		return false
	return true
static func dicts_are_eq(D1 : Dictionary, D2: Dictionary) -> bool:
	if not dict_is_playable_pair(D1) or not dict_is_playable_pair(D2): return false
	if  D1["FRONT"][DictFields.EXPANSIONID]  == D2["FRONT"][DictFields.EXPANSIONID]  and \
		D1["FRONT"][DictFields.RARITY]       == D2["FRONT"][DictFields.RARITY]       and \
		D1["FRONT"][DictFields.TYPE]         == D2["FRONT"][DictFields.TYPE]         and \
		D1["FRONT"][DictFields.CONTENTINDEX] == D2["FRONT"][DictFields.CONTENTINDEX] and \
		D1["BACK"][DictFields.EXPANSIONID]   == D2["BACK"][DictFields.EXPANSIONID]   and \
		D1["BACK"][DictFields.RARITY]        == D2["BACK"][DictFields.RARITY]        and \
		D1["BACK"][DictFields.CONTENTINDEX]  == D2["BACK"][DictFields.CONTENTINDEX]: return true
	else: return false

func _init(Expansion_ID: DATA.ExpansionIDs, Content_Rarity: DATA.Rarities, Content_Type: DATA.ContentTypes, Content_Idx: int,  Content_Name: String, Content_Img: Texture2D, \
		   Paired_Expansion_ID: DATA.ExpansionIDs, Paired_Rarity: DATA.Rarities, Paired_Idx: int,  Paired_Name: String, Paired_Img: Texture2D):
	# save information
	super._init(Expansion_ID, Content_Rarity, Content_Type, Content_Idx,  Content_Name, Content_Img)
	PairedExpansionID = Paired_Expansion_ID
	PairedRarity = Paired_Rarity
	PairedIndex = Paired_Idx
	PairedName = Paired_Name
	PairedImg = Paired_Img
	PairedStats = DATA.get_content_stats(Expansion_ID, Paired_Rarity, Content_Type, Paired_Idx)
	
	var plain_name: String = PairedName.replace(" ", "_").to_lower()
	set_name(name+"_"+plain_name+"_"+str(int(RNG.random_value()*1000)))
	
	# create card text
	var name_label = Label3D.new()
	name_label.set_text(Paired_Name)
	name_label.set_name(plain_name+"_name")
	name_label.rotation.y = PI
	name_label.position.y = -0.3
	name_label.position.z = -0.011
	
	
	var flavor_label = Label3D.new()
	flavor_label.set_text(PairedStats[DATA.CritterDescriptionFields.FLAVOR])
	flavor_label.set_name(plain_name+"_flavor")
	flavor_label.set_pixel_size(0.003)
	flavor_label.set_width(700.0)
	flavor_label.set_vertical_alignment(VERTICAL_ALIGNMENT_TOP)
	flavor_label.set_autowrap_mode(TextServer.AUTOWRAP_WORD)
	flavor_label.font = load("res://1_ASSETS/UI/italicize.tres")
	flavor_label.position.y = -0.45
	flavor_label.position.z = -0.011
	flavor_label.rotation.y = PI
	
	var stats_display = StatsDisplay.new(Type, PairedStats)
	stats_display.set_name(plain_name+"_stats")
	stats_display.position.y = -1.25
	stats_display.position.z = -0.011
	stats_display.rotation.y = PI
	
	# create sprite
	PairedSprite = Sprite3D.new()
	PairedSprite.set_name("paired_"+plain_name+"_sprite")
	PairedSprite.set_texture_filter(BaseMaterial3D.TEXTURE_FILTER_NEAREST)
	PairedSprite.set_texture(PairedImg)
	PairedSprite.set_pixel_size(2.0/PairedImg.get_width())
	PairedSprite.position.z = -0.0055
	Sprite.position.z = 0.0055
	PairedSprite.position.y = 0.625
	PairedSprite.rotation.y = PI
	
	# create mesh 
	var M: Mesh = load("res://1_ASSETS/cards/pair_with_uv.tres")
	set_mesh(M)
	add_child(PairedSprite)
	add_child(name_label)
	add_child(flavor_label)
	add_child(stats_display)
	
	var mat: StandardMaterial3D = DATA.create_paired_rarity_material(Rarity, PairedRarity) 
	set_surface_override_material(0, mat)
# ================ #
# internal utility #
# ================ #
#func _exit_tree() -> void:
func _notification(what: int) -> void: 
	if what == NOTIFICATION_PREDELETE:
		PairedSprite.queue_free()

func _disable():
	super._disable()
	
	#var img = PairedImg.get_image()
	#var width = img.get_width()
	#var height = img.get_height()
	#var bw_img = Image.create(width, height, false, Image.FORMAT_RGBA8)
	#
	#for y in range(height):
		#for x in range(width):
			#var color = img.get_pixel(x, y)
			#var luminance = (color.r * 0.2126 + color.g * 0.7152 + color.b * 0.0722)
			#var bw_color = Color(luminance, luminance, luminance, color.a)
			#bw_img.set_pixel(x, y, bw_color)
	
	#PairedSprite.set_texture(ImageTexture.create_from_image(bw_img))
	
	var img = Sprite.texture.get_image()
	img.convert(Image.Format.FORMAT_L8)
	Sprite.set_texture(ImageTexture.create_from_image(img))
	@warning_ignore("int_as_enum_without_match")
	var mat: StandardMaterial3D = DATA.create_paired_rarity_material(6 as DATA.Rarities, 6 as DATA.Rarities) 
	set_surface_override_material(0, mat)
