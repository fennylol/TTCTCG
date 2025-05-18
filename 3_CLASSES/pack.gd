extends MeshInstance3D
class_name Pack

var Rarity: DATA.Rarities
var Content: Array[Card]

func _init(R : DATA.Rarities, C : Array[Card]) -> void:
	# save information
	Rarity = R
	Content = C
	
	# create pack top mesh
	var pack_top = MeshInstance3D.new()
	pack_top.set_mesh(load("res://1_ASSETS/packs/pack_top_mesh.tres"))
	pack_top.set_name(DATA.Rarities.find_key(Rarity).to_lower()+"_pack_"+"_top")
	add_child(pack_top)
	
	#create pack bottom mesh
	var pack_bottom = MeshInstance3D.new()
	pack_bottom.set_mesh(load("res://1_ASSETS/packs/pack_bottom_mesh.tres"))
	pack_bottom.set_name(DATA.Rarities.find_key(Rarity).to_lower()+"_pack_"+"_bottom")
	add_child(pack_bottom)
	
	# create cards
	for i in Content.size():
		var card: Card = Content[i]
		card.position.z -= 0.01 * i
		add_child(card)
