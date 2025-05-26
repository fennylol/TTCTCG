extends MeshInstance3D
class_name Card

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
	set_name(Name.replace(" ", "_").to_lower()+"_"+str(int(RNG.random_value()*1000)))
	
	# create sprite
	var S := Sprite3D.new()
	S.set_name(N.replace(" ", "_").to_lower()+"_sprite")
	S.set_texture_filter(BaseMaterial3D.TEXTURE_FILTER_NEAREST)
	S.set_texture(Img)
	S.set_pixel_size(2.0/Img.get_width())
	S.position.z = 0.001
	
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
	add_child(S)
