extends Card
class_name  PlayablePair

var PairedExpansionID: DATA.ExpansionIDs
var PairedRarity: DATA.Rarities
var PairedIndex: int

var PairedName: String
var PairedImg: Texture2D
var PairedStats: Dictionary

var PairedSprite : Sprite3D
var PairedDisplay: StatsDisplay
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
	
	var new_core_mesh: Mesh = load("res://1_ASSETS/cards/tres/core_pair.tres")               if Rarity <  DATA.Rarities.EPIC and PairedRarity <  DATA.Rarities.EPIC else \
							  load("res://1_ASSETS/cards/tres/core_pair_true_full_art.tres") if Rarity >= DATA.Rarities.EPIC and PairedRarity >= DATA.Rarities.EPIC else \
							  load("res://1_ASSETS/cards/tres/core_pair_full_art.tres")
	Core.set_mesh(new_core_mesh)
	Core.set_name(plain_name + "_core_mesh")
	if (Rarity < DATA.Rarities.EPIC and PairedRarity >= DATA.Rarities.EPIC): Core.rotation.y += PI
	
	# create card text
	#var text_mat = DATA.create_text_shader_material(0)
	var name_label = Label3D.new()
	name_label.set_text(Paired_Name)
	name_label.set_name(plain_name+"_name")
	name_label.set_render_priority(2)
	name_label.set_outline_render_priority(1)
	#name_label.set_material_override(text_mat)
	name_label.rotation.y = PI
	name_label.position.y = TEXT_NAME_HEIGHT
	name_label.position.z = -TEXT_DEPTH
	add_child(name_label)
	
	

	var flavor_label = Label3D.new()
	flavor_label.set_text(PairedStats[DATA.CritterDescriptionFields.FLAVOR])
	flavor_label.set_name(plain_name+"_flavor")
	flavor_label.set_render_priority(2)
	flavor_label.set_outline_render_priority(1)
	#flavor_label.set_material_override(text_mat)
	flavor_label.set_pixel_size(0.003)
	flavor_label.set_width(700.0)
	flavor_label.set_vertical_alignment(VERTICAL_ALIGNMENT_TOP)
	flavor_label.set_autowrap_mode(TextServer.AUTOWRAP_WORD)
	flavor_label.font = load("res://1_ASSETS/UI/italicize.tres")
	flavor_label.position.y = TEXT_FLAVOR_HEIGHT
	flavor_label.position.z = -TEXT_DEPTH
	flavor_label.rotation.y = PI
	add_child(flavor_label)
	
	PairedDisplay = StatsDisplay.new(Type, PairedStats)
	PairedDisplay.set_name(plain_name+"_stats")
	PairedDisplay.position.y = STATS_HEIGHT
	PairedDisplay.position.z = -TEXT_DEPTH*1.1
	PairedDisplay.rotation.y = PI
	add_child(PairedDisplay)
	
	# create sprite
	PairedSprite = Sprite3D.new()
	PairedSprite.set_name("paired_"+plain_name+"_sprite")
	PairedSprite.set_texture_filter(BaseMaterial3D.TEXTURE_FILTER_NEAREST)
	PairedSprite.set_texture(PairedImg)
	PairedSprite.set_pixel_size(2.0/PairedImg.get_width())
	PairedSprite.position.y = SPRITE_HEIGHT if PairedRarity < DATA.Rarities.EPIC else SPRITE_FULLART_HEIGHT
	PairedSprite.position.z = -SPRITE_DEPTH
	PairedSprite.rotation.y = PI
	add_child(PairedSprite)
	
	_change_material(false)

func _change_material(shaded: bool) -> void:
	if shaded and (Rarity >= DATA.Rarities.EPIC or \
				   PairedRarity >= DATA.Rarities.EPIC):
		var texture_seed = int(RNG.random_value()*0xBEEF)
		var mat: ShaderMaterial = DATA.create_paired_rarity_shader_material(Rarity, PairedRarity, texture_seed) 
		#var sprite_mat = DATA.create_sprite_shader_material(Sprite.texture, texture_seed)
		#var paired_sprite_mat = DATA.create_sprite_shader_material(PairedSprite.texture, texture_seed)
		set_surface_override_material(0, mat)
		#Sprite.set_material_override(sprite_mat)
		#PairedSprite.set_material_override(paired_sprite_mat)
		StatDisplay._change_material(false)
		PairedDisplay._change_material(false)
	else:
		var mat: StandardMaterial3D = DATA.create_paired_rarity_material(Rarity, PairedRarity) 
		set_surface_override_material(0, mat)
		Sprite.set_material_override(null)
		PairedSprite.set_material_override(null)
		StatDisplay._change_material(true)
		PairedDisplay._change_material(true)
	var core_mat: StandardMaterial3D = DATA.create_paired_rarity_material(Rarity, PairedRarity) 
	Core.set_surface_override_material(0, core_mat)
# ================ #
# internal utility #
# ================ #
#func _exit_tree() -> void:
func _notification(what: int) -> void: 
	if what == NOTIFICATION_PREDELETE:
		PairedSprite.queue_free()

func _disable():
	super._disable()
	
	var img = Sprite.texture.get_image()
	img.convert(Image.Format.FORMAT_L8)
	Sprite.set_texture(ImageTexture.create_from_image(img))
	@warning_ignore("int_as_enum_without_match")
	var mat: StandardMaterial3D = DATA.create_paired_rarity_material(6 as DATA.Rarities, 6 as DATA.Rarities) 
	set_surface_override_material(0, mat)
