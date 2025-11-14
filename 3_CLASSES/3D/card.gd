extends MeshInstance3D
class_name Card

signal AnimationComplete(anim_name: String)

const CARD_WIDTH    : float = 2.5
const CARD_HEIGHT   : float = 3
const NORMAL_SPEED  : float = 1.0
const SKIPPING_SPEED: float = 3.0

# element position consts
const SPRITE_DEPTH         : float = 0.003
const SPRITE_HEIGHT        : float = 0.625
const SPRITE_FULLART_HEIGHT: float = 0.0
const TEXT_DEPTH           : float = 0.006
const TEXT_NAME_HEIGHT     : float = -0.3
const TEXT_FLAVOR_HEIGHT   : float = -0.45
const STATS_HEIGHT         : float = -1.25


var ExpansionID : DATA.ExpansionIDs
var Rarity      : DATA.Rarities
var Type        : DATA.ContentTypes
var ContentIndex: int
var Name : String
var Img  : Texture2D
var Stats: Dictionary
var Core : MeshInstance3D

var Animations : AnimationPlayer
var Sprite     : Sprite3D
var StatDisplay: StatsDisplay

enum DictFields {EXPANSIONID, RARITY, TYPE, CONTENTINDEX}

func set_anim_speed(speed: float) -> void: Animations.speed_scale = speed
func get_anim_speed()            -> float: return Animations.speed_scale
# ====================== #
# creation & destruction #
# ====================== #
func reduce_to_dict() -> Dictionary: 
	queue_free()
	return copy_to_dict()
func copy_to_dict() -> Dictionary: 
	return { 
		DictFields.EXPANSIONID  : ExpansionID, 
		DictFields.RARITY       : Rarity, 
		DictFields.TYPE         : Type, 
		DictFields.CONTENTINDEX : ContentIndex
	}
static func restore_from_dict(Dict: Dictionary) -> Card: 
	assert(dict_is_card(Dict, true), "card.gd - restore_from_dict(): Dict is not a Card")
	return DATA.get_expansion_content(
		Dict[DictFields.EXPANSIONID],
		Dict[DictFields.RARITY],
		Dict[DictFields.TYPE],
		Dict[DictFields.CONTENTINDEX]
	)
static func copy_card(card: Card) -> Card: 
	var dict := card.copy_to_dict()
	return restore_from_dict(dict)
static func dict_is_card(Dict: Dictionary, LogResult: bool = false) -> bool:
	if not Dict.keys().has(DictFields.EXPANSIONID):  
		if LogResult: LOGGER.log_msg("card.gd - dict_is_card(): dict is not a Card, no EXPANSIONID",  LOGGER.Flags.WARN)
		return false
	if not Dict.keys().has(DictFields.TYPE):         
		if LogResult: LOGGER.log_msg("card.gd - dict_is_card(): dict is not a Card, no TYPE",         LOGGER.Flags.WARN)
		return false
	if not Dict.keys().has(DictFields.RARITY):       
		if LogResult: LOGGER.log_msg("card.gd - dict_is_card(): dict is not a Card, no RARITY",       LOGGER.Flags.WARN)
		return false
	if not Dict.keys().has(DictFields.CONTENTINDEX): 
		if LogResult: LOGGER.log_msg("card.gd - dict_is_card(): dict is not a Card, no CONTENTINDEX", LOGGER.Flags.WARN)
		return false
	return true
static func dicts_are_eq(D1 : Dictionary, D2: Dictionary) -> bool:
	if not dict_is_card(D1) or not dict_is_card(D2): return false
	if  D1[DictFields.EXPANSIONID]  == D2[DictFields.EXPANSIONID] and \
		D1[DictFields.RARITY]       == D2[DictFields.RARITY]      and \
		D1[DictFields.TYPE]         == D2[DictFields.TYPE]        and \
		D1[DictFields.CONTENTINDEX] == D2[DictFields.CONTENTINDEX]: return true
	else: return false

#func _exit_tree() -> void:
func _notification(what: int) -> void: 
	if what == NOTIFICATION_PREDELETE:
		Animations.queue_free()
		Sprite.queue_free()
func _init(Expansion_ID: DATA.ExpansionIDs, Content_Rarity: DATA.Rarities, Content_Type: DATA.ContentTypes, Content_Idx: int,  Content_Name: String, Content_Img: Texture2D) -> void:
	# save information
	ExpansionID = Expansion_ID
	Rarity = Content_Rarity
	Type = Content_Type
	ContentIndex = Content_Idx
	Name = Content_Name
	Img = Content_Img
	Stats = DATA.get_content_stats(Expansion_ID, Content_Rarity, Content_Type, Content_Idx)
	
	var plain_name: String = Name.replace(" ", "_").to_lower()
	set_name(plain_name+"_"+str(int(RNG.random_value()*1000)))
	
	# create mesh 
	#var new_mesh: Mesh = load("res://1_ASSETS/cards/basic_card_mesh.tres")
	var new_mesh: Mesh = load("res://1_ASSETS/cards/tres/frame.tres")
	set_mesh(new_mesh)
	
	var new_core_mesh: Mesh = load("res://1_ASSETS/cards/tres/core_card.tres") if Rarity < DATA.Rarities.EPIC else load("res://1_ASSETS/cards/tres/core_card_full_art.tres")
	Core = MeshInstance3D.new()
	Core.set_name(plain_name + "_core_mesh")
	Core.set_mesh(new_core_mesh)
	add_child(Core)
	
	#create card text
	var name_label = Label3D.new()
	name_label.set_text(Name)
	name_label.set_name(plain_name+"_name")
	name_label.set_render_priority(2)
	name_label.set_outline_render_priority(1)
	#name_label.set_material_override(text_mat)
	name_label.position.y = TEXT_NAME_HEIGHT
	name_label.position.z = TEXT_DEPTH
	add_child(name_label)
	
	var flavor_label = Label3D.new()
	flavor_label.set_text(Stats[DATA.CritterDescriptionFields.FLAVOR])
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
	flavor_label.position.z = TEXT_DEPTH
	add_child(flavor_label)
	
	StatDisplay = StatsDisplay.new(Type, Stats)
	StatDisplay.set_name(plain_name+"_stats")
	StatDisplay.position.y = STATS_HEIGHT
	StatDisplay.position.z = TEXT_DEPTH
	add_child(StatDisplay)
	
	# create sprite
	Sprite = Sprite3D.new()
	Sprite.set_name(plain_name+"_sprite")
	Sprite.set_texture_filter(BaseMaterial3D.TEXTURE_FILTER_NEAREST)
	Sprite.set_texture(Img)
	Sprite.set_pixel_size(2.0/Img.get_width())
	Sprite.position.y = SPRITE_HEIGHT if Rarity < DATA.Rarities.EPIC else SPRITE_FULLART_HEIGHT
	Sprite.position.z = SPRITE_DEPTH
	add_child(Sprite)
	
	# create animation player
	Animations = AnimationPlayer.new()
	Animations.set_name(plain_name+"_animations")
	Animations.add_animation_library("moves", load("res://1_ASSETS/cards/animations/basic_card_anims.res"))
	Animations.animation_finished.connect(AnimationComplete.emit)
	add_child(Animations)
	
	if self is not PlayablePair: _change_material(false)


func _change_material(shaded: bool) -> void:
	if shaded and Rarity >= DATA.Rarities.EPIC:
		var texture_seed = int(RNG.random_value()*0xBEEF)
		var mat: ShaderMaterial = DATA.create_rarity_shader_material(Rarity, texture_seed)
		var sprite_mat = DATA.create_sprite_shader_material(Sprite.texture, texture_seed)
		set_surface_override_material(0, mat)
		Sprite.set_material_override(sprite_mat)
		StatDisplay._change_material(false)
	else:
		var mat: StandardMaterial3D = DATA.create_rarity_material(Rarity)
		set_surface_override_material(0, mat)
		Sprite.set_material_override(null)
		StatDisplay._change_material(true)
	
	if shaded and (Rarity == DATA.Rarities.RARE or \
				   Rarity == DATA.Rarities.HOLY_MOLY):
		StatDisplay._change_material(true)
	else:
		StatDisplay._change_material(false)
	
	var core_mat: StandardMaterial3D = DATA.create_rarity_material(Rarity)
	Core.set_surface_override_material(0, core_mat)
# ================ #
# internal utility #
# ================ #
func _disable():
	var img = Sprite.texture.get_image()
	img.convert(Image.Format.FORMAT_L8)
	Sprite.set_texture(ImageTexture.create_from_image(img))
	
	@warning_ignore("int_as_enum_without_match")
	var mat: StandardMaterial3D = DATA.create_rarity_material(6 as DATA.Rarities)
	set_surface_override_material(0, mat)

func play_anim(AnimName : StringName):
	Animations.play(AnimName)
