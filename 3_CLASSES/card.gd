extends MeshInstance3D
class_name Card

signal AnimationComplete(anim_name: String)

const CARD_WIDTH: float = 2.5
const CARD_HEIGHT: float = 3

var SetID: int
var Name: String
var Type: DATA.ContentTypes
var Rarity: DATA.Rarities
var Img: Texture2D

func _init(ID: int, N: String, T: DATA.ContentTypes, R: DATA.Rarities, I: Texture2D) -> void:
	# save information
	SetID = ID
	Name = N
	Type = T
	Rarity = R
	Img = I
	
	var plain_name: String = Name.replace(" ", "_").to_lower()
	
	set_name(plain_name+"_"+str(int(RNG.random_value()*1000)))
	
	# create sprite
	var S := Sprite3D.new()
	S.set_name(plain_name+"_sprite")
	S.set_texture_filter(BaseMaterial3D.TEXTURE_FILTER_NEAREST)
	S.set_texture(Img)
	S.set_pixel_size(2.0/Img.get_width())
	S.position.z = 0.001
	
	# create animation player
	var A = AnimationPlayer.new()
	A.set_name(plain_name+"_animations")
	A.add_animation_library("moves", load("res://3_CLASSES/card_anims.res"))
	A.animation_finished.connect(AnimationComplete.emit)
	
	# create mesh 
	var M: Mesh = load("res://1_ASSETS/cards/basic_card_mesh.tres")
	
	# update card mesh and sprite according to rarity
	#if Rarity <= DATA.Rarities.UNCOMMON: 
		#print("added ", Name, ", a basic card, to the tree")
		#S.position.y = 0.625
	#elif Rarity <= DATA.Rarities.EPIC: 
		#print("added ", Name, ", a full art card, to the tree")
	#else: 
		#print("added ", Name, ", a rainbow rare, to the tree")
	S.position.y = 0.625
	
	set_mesh(M)
	add_child(A)
	add_child(S)
	
