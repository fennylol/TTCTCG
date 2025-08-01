extends Card
class_name  PlayablePair

var ShowingAtk : bool = true

var PairedSetID: int
var PairedName: String
var PairedType: DATA.ContentTypes
var PairedRarity: DATA.Rarities
var PairedImg: Texture2D

var PairedSprite := Sprite3D.new()

const ROT_SPEED : float = 5.0

static func create_from_two_cards(Atk : Card, Def : Card) -> PlayablePair: return PlayablePair.new(Atk.SetID, Atk.Name, Atk.Type, Atk.Rarity, Atk.Img, Def.SetID, Def.Name, Def.Type, Def.Rarity, Def.Img)

func _init(ID: int, N: String, T: DATA.ContentTypes, R: DATA.Rarities, I: Texture2D, \
		   PAIREDID: int, PAIREDN: String, PAIREDT: DATA.ContentTypes, PAIREDR: DATA.Rarities, PAIREDI: Texture2D):
	
	PairedSetID = PAIREDID
	PairedName = PAIREDN
	PairedType = PAIREDT
	PairedRarity = PAIREDR
	PairedImg = PAIREDI
	
	super._init(ID, N, T, R, I)
	var plain_name: String = PAIREDN.replace(" ", "_").to_lower()
	
	set_name(name+"_"+plain_name+"_"+str(int(RNG.random_value()*1000)))
	
	# create sprite
	PairedSprite.set_name("paired_"+plain_name+"_sprite")
	PairedSprite.set_texture_filter(BaseMaterial3D.TEXTURE_FILTER_NEAREST)
	PairedSprite.set_texture(PairedImg)
	PairedSprite.set_pixel_size(2.0/PairedImg.get_width())
	PairedSprite.position.z = -0.0055
	Sprite.position.z = 0.0055
	PairedSprite.position.y = 0.625
	PairedSprite.rotation.y = PI
	
	# create mesh 
	var M: Mesh = load("res://1_ASSETS/cards/paired_basic_card_mesh.tres")
	
	# update card mesh and sprite according to rarity
	#if Rarity <= DATA.Rarities.UNCOMMON: 
		#print("added ", Name, ", a basic card, to the tree")
		#S.position.y = 0.625
	#elif Rarity <= DATA.Rarities.EPIC: 
		#print("added ", Name, ", a full art card, to the tree")
	#else: 
		#print("added ", Name, ", a rainbow rare, to the tree")
	
	set_mesh(M)
	add_child(PairedSprite)

func _process(delta: float) -> void:
	if ShowingAtk: 
		rotation.y = move_toward(rotation.y, 0, ROT_SPEED * delta)
	else:
		rotation.y = move_toward(rotation.y, PI, ROT_SPEED * delta)
