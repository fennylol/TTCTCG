extends Card
class_name  PlayablePair

var PairedSetID: int
var PairedExpansionID: DATA.ExpansionIDs
var PairedName: String
var PairedType: DATA.ContentTypes
var PairedRarity: DATA.Rarities
var PairedImg: Texture2D

var PairedSprite := Sprite3D.new()

const ROT_SPEED : float = 5.0

static func create_from_two_cards(Atk : Card, Def : Card) -> PlayablePair: return PlayablePair.new(Atk.SetID, Atk.ExpansionID, Atk.Name, Atk.Type, Atk.Rarity, Atk.Img, Def.SetID, Def.ExpansionID, Def.Name, Def.Type, Def.Rarity, Def.Img)
static func create_from_playable_pair(card: PlayablePair) -> PlayablePair: return PlayablePair.new(card.SetID, card.ExpansionID, card.Name, card.Type, card.Rarity, card.Img, card.PairedSetID, card.PairedExpansionID, card.PairedName, card.PairedType, card.PairedRarity, card.PairedImg)
static func create_flipped_card(card : PlayablePair) -> PlayablePair: return PlayablePair.new(card.PairedSetID, card.PairedExpansionID, card.PairedName, card.PairedType, card.PairedRarity, card.PairedImg, card.SetID, card.ExpansionID, card.Name, card.Type, card.Rarity, card.Img)
static func parse_dict(dict: Dictionary) -> PlayablePair:
	assert(dict["front"] is Array)
	assert(dict["back"] is Array)
	assert(dict["front"].size() == 4)
	assert(dict["back"].size() == 4)
	
	var front_data: Array = dict["front"]
	var back_data: Array = dict["back"]
	var front_card: Card = DATA.get_expansion_content(front_data[0],front_data[1],front_data[2],front_data[3])
	var back_card: Card = DATA.get_expansion_content(back_data[0] ,back_data[1], back_data[2], back_data[3])
	return PlayablePair.create_from_two_cards(front_card, back_card)

func to_dict() -> Dictionary:
	return {
		"front" : [ExpansionID, Rarity, Type, SetID],
		"back" : [PairedExpansionID, PairedRarity, PairedType, PairedSetID]
	}
	#return [Paired]

func _init(ID: int, E: DATA.ExpansionIDs, N: String, T: DATA.ContentTypes, R: DATA.Rarities, I: Texture2D, \
		   PAIREDID: int, PAIREDE: DATA.ExpansionIDs, PAIREDN: String, PAIREDT: DATA.ContentTypes, PAIREDR: DATA.Rarities, PAIREDI: Texture2D):
	
	PairedSetID = PAIREDID
	PairedExpansionID = PAIREDE
	PairedName = PAIREDN
	PairedType = PAIREDT
	PairedRarity = PAIREDR
	PairedImg = PAIREDI
	
	super._init(ID, E, N, T, R, I)
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
	var M: Mesh = load("res://1_ASSETS/cards/pair_with_uv.tres")
	
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
	
	var mat: StandardMaterial3D = DATA.create_paired_rarity_material(Rarity, PairedRarity) 
	set_surface_override_material(0, mat)

func _disable():
	super._disable()
	
	var img = PairedImg.get_image()
	var width = img.get_width()
	var height = img.get_height()
	var bw_img = Image.create(width, height, false, Image.FORMAT_RGBA8)
	
	for y in range(height):
		for x in range(width):
			var color = img.get_pixel(x, y)
			var luminance = (color.r * 0.2126 + color.g * 0.7152 + color.b * 0.0722)
			var bw_color = Color(luminance, luminance, luminance, color.a)
			bw_img.set_pixel(x, y, bw_color)
	
	PairedSprite.set_texture(ImageTexture.create_from_image(bw_img))
	var mat: StandardMaterial3D = DATA.create_paired_rarity_material(6, 6) 
	set_surface_override_material(0, mat)
	
