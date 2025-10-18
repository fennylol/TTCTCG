extends MeshInstance3D
class_name Card

signal AnimationComplete(anim_name: String)

const CARD_WIDTH: float = 2.5
const CARD_HEIGHT: float = 3

var ExpansionID: DATA.ExpansionIDs
var Type: DATA.ContentTypes
var Rarity: DATA.Rarities
var ContentIndex: int

var Name: String
var Img: Texture2D

var Animations : AnimationPlayer
var Sprite : Sprite3D

enum DictFields {EXPANSIONID, TYPE, RARITY, CONTENTINDEX}

#static func create_from_card(card: Card) -> Card: return Card.new(card.SetID, card.ExpansionID, card.Name, card.Type, card.Rarity, card.Img)

# ====================== #
# creation & destruction #
# ====================== #
func copy_to_dict() -> Dictionary: return { DictFields.EXPANSIONID : ExpansionID, DictFields.TYPE : Type, DictFields.RARITY : Rarity, DictFields.CONTENTINDEX : ContentIndex}
func reduce_to_dict() -> Dictionary: queue_free(); return copy_to_dict()
static func restore_from_dict(Dict: Dictionary) -> Card: 
	if not Dict.keys().has(DictFields.EXPANSIONID):  LOGGER.log_msg("card.gd: cannot restore card from dict with no EXPANSIONID",  LOGGER.Flags.ERR)
	if not Dict.keys().has(DictFields.TYPE):         LOGGER.log_msg("card.gd: cannot restore card from dict with no TYPE",         LOGGER.Flags.ERR)
	if not Dict.keys().has(DictFields.RARITY):       LOGGER.log_msg("card.gd: cannot restore card from dict with no RARITY",       LOGGER.Flags.ERR)
	if not Dict.keys().has(DictFields.CONTENTINDEX): LOGGER.log_msg("card.gd: cannot restore card from dict with no CONTENTINDEX", LOGGER.Flags.ERR)
	return DATA.get_expansion_content(
		Dict[DictFields.EXPANSIONID],
		Dict[DictFields.TYPE],
		Dict[DictFields.RARITY],
		Dict[DictFields.CONTENTINDEX]
	)

#ExpansionID : ExpansionIDs, ContentRarity : Rarities, ContentType : ContentTypes, ContentIndex : int


func _init(Expansion_ID: DATA.ExpansionIDs, Content_Type: DATA.ContentTypes, Content_Rarity: DATA.Rarities, Content_Idx: int,  Content_Name: String, Content_Img: Texture2D) -> void:
	# save information
	ExpansionID = Expansion_ID
	Type = Content_Type
	Rarity = Content_Rarity
	ContentIndex = Content_Idx
	
	Name = Content_Name
	Img = Content_Img
	
	var plain_name: String = Name.replace(" ", "_").to_lower()
	
	set_name(plain_name+"_"+str(int(RNG.random_value()*1000)))
	
	# create sprite
	Sprite = Sprite3D.new()
	Sprite.set_name(plain_name+"_sprite")
	Sprite.set_texture_filter(BaseMaterial3D.TEXTURE_FILTER_NEAREST)
	Sprite.set_texture(Img)
	Sprite.set_pixel_size(2.0/Img.get_width())
	Sprite.position.z = 0.001
	Sprite.position.y = 0.625
	# update card mesh and sprite according to rarity
	#if Rarity <= DATA.Rarities.UNCOMMON: 
		#print("added ", Name, ", a basic card, to the tree")
		#S.position.y = 0.625
	#elif Rarity <= DATA.Rarities.EPIC: 
		#print("added ", Name, ", a full art card, to the tree")
	#else: 
		#print("added ", Name, ", a rainbow rare, to the tree")
	
	
	# create animation player
	Animations = AnimationPlayer.new()
	Animations.set_name(plain_name+"_animations")
	Animations.add_animation_library("moves", load("res://1_ASSETS/cards/animations/basic_card_anims.res"))
	Animations.animation_finished.connect(AnimationComplete.emit)
	
	# create mesh 
	var M: Mesh = load("res://1_ASSETS/cards/basic_card_mesh.tres")
	
	set_mesh(M)
	add_child(Animations)
	add_child(Sprite)
	
	var mat: StandardMaterial3D = DATA.create_rarity_material(Rarity)
	set_surface_override_material(0, mat)

func _notification(what: int) -> void: 
	if what == NOTIFICATION_PREDELETE:
		Animations.queue_free()
		Sprite.queue_free()

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
