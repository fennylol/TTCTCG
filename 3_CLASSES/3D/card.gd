extends MeshInstance3D
class_name Card

signal AnimationComplete(anim_name: String)

const CARD_WIDTH    : float = 2.5
const CARD_HEIGHT   : float = 3
const NORMAL_SPEED  : float = 1.0
const SKIPPING_SPEED: float = 3.0

var ExpansionID : DATA.ExpansionIDs
var Rarity      : DATA.Rarities
var Type        : DATA.ContentTypes
var ContentIndex: int
var Name : String
var Img  : Texture2D
var Stats: Dictionary

var Animations: AnimationPlayer
var Sprite    : Sprite3D

enum DictFields {EXPANSIONID, RARITY, TYPE, CONTENTINDEX}

func set_anim_speed(speed: float) -> void: Animations.speed_scale = speed
func get_anim_speed() -> float: return Animations.speed_scale
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
	
	#create card text
	var name_label = Label3D.new()
	name_label.set_text(Name)
	name_label.set_name(plain_name+"_name")
	name_label.position.y = -0.3
	name_label.position.z = 0.011
	
	var flavor_label = Label3D.new()
	flavor_label.set_text(Stats[DATA.CritterDescriptionFields.FLAVOR])
	flavor_label.set_name(plain_name+"_flavor")
	flavor_label.set_pixel_size(0.003)
	flavor_label.set_width(700.0)
	flavor_label.set_vertical_alignment(VERTICAL_ALIGNMENT_TOP)
	flavor_label.set_autowrap_mode(TextServer.AUTOWRAP_WORD)
	flavor_label.font = load("res://1_ASSETS/UI/italicize.tres")
	flavor_label.position.y = -0.45
	flavor_label.position.z = 0.011
	
	var stats_display = StatsDisplay.new(Type, Stats)
	stats_display.set_name(plain_name+"_stats")
	stats_display.position.y = -1.25
	stats_display.position.z = 0.011
	
	# create sprite
	Sprite = Sprite3D.new()
	Sprite.set_name(plain_name+"_sprite")
	Sprite.set_texture_filter(BaseMaterial3D.TEXTURE_FILTER_NEAREST)
	Sprite.set_texture(Img)
	Sprite.set_pixel_size(2.0/Img.get_width())
	Sprite.position.z = 0.001
	Sprite.position.y = 0.625
	
	# create animation player
	Animations = AnimationPlayer.new()
	Animations.set_name(plain_name+"_animations")
	Animations.add_animation_library("moves", load("res://1_ASSETS/cards/animations/basic_card_anims.res"))
	Animations.animation_finished.connect(AnimationComplete.emit)
	
	# create mesh 
	var new_mesh: Mesh = load("res://1_ASSETS/cards/basic_card_mesh.tres")
	set_mesh(new_mesh)
	
	add_child(Animations)
	add_child(Sprite)
	add_child(name_label)
	add_child(flavor_label)
	add_child(stats_display)
	
	var mat: StandardMaterial3D = DATA.create_rarity_material(Rarity)
	set_surface_override_material(0, mat)

# ================ #
# internal utility #
# ================ #
func _disable():
	var img = Img.get_image()
	var width = img.get_width()
	var height = img.get_height()
	var bw_img = Image.create(width, height, false, Image.FORMAT_RGBA8)
	
	for y in range(height):
		for x in range(width):
			var color = img.get_pixel(x, y)
			var luminance = (color.r * 0.2126 + color.g * 0.7152 + color.b * 0.0722)
			var bw_color = Color(luminance, luminance, luminance, color.a)
			bw_img.set_pixel(x, y, bw_color)
	
	Sprite.set_texture(ImageTexture.create_from_image(bw_img))
	@warning_ignore("int_as_enum_without_match")
	var mat: StandardMaterial3D = DATA.create_rarity_material(6 as DATA.Rarities)
	set_surface_override_material(0, mat)

func play_anim(AnimName : StringName):
	Animations.play(AnimName)
