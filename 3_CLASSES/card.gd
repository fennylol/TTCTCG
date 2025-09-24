extends MeshInstance3D
class_name Card

signal AnimationComplete(anim_name: String)

const CARD_WIDTH: float = 2.5
const CARD_HEIGHT: float = 3

var SetID: int
var ExpansionID: DATA.ExpansionIDs
var Name: String
var Type: DATA.ContentTypes
var Rarity: DATA.Rarities
var Img: Texture2D

var Animations := AnimationPlayer.new()
var Sprite := Sprite3D.new()

enum DictGuide {SETID, EXPANSIONID, TYPE, RARITY}

func _init(ID: int, E: DATA.ExpansionIDs, N: String, T: DATA.ContentTypes, R: DATA.Rarities, I: Texture2D) -> void:
	# save information
	SetID = ID
	ExpansionID = E
	Name = N
	Type = T
	Rarity = R
	Img = I
	
	var plain_name: String = Name.replace(" ", "_").to_lower()
	
	set_name(plain_name+"_"+str(int(RNG.random_value()*1000)))
	
	# create sprite
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

func play_anim(AnimName : StringName):
	Animations.play(AnimName)
