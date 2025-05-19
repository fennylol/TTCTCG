extends Node3D
class_name Pack

signal finished

# content
var Rarity: DATA.Rarities
var Content: Array[Card]
var ActiveContent: int = OpeningStates.SEALED
enum OpeningStates {SEALED = -2, OPEN = -1, LOWERED = 0}

# mesh parts
var PackTop := MeshInstance3D.new()
var PackBody := MeshInstance3D.new()

# consts
const LOWERED_PACK_HEIGHT: float = -5.0
const LERP_SPEED: float = 1.0
const KILL_TIMER: float = 1.5

func _init(R : DATA.Rarities, C : Array[Card]) -> void:
	# save information
	Rarity = R
	Content = C
	
	# TODO: set pack texture
	
	# create pack top mesh
	PackTop.set_mesh(load("res://1_ASSETS/packs/pack_top_mesh.tres"))
	PackTop.set_name(DATA.Rarities.find_key(Rarity).to_lower()+"_pack_top")
	add_child(PackTop)
	
	# create pack body mesh
	PackBody.set_mesh(load("res://1_ASSETS/packs/pack_bottom_mesh.tres"))
	PackBody.set_name(DATA.Rarities.find_key(Rarity).to_lower()+"_pack_"+"_bottom")
	add_child(PackBody)
	
	# create cards
	for i in Content.size():
		var card: Card = Content[i]
		card.position.z -= 0.01 * i
		add_child(card)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Next"): 
		ActiveContent += 1
		if ActiveContent == Content.size()+1:
			print("killing.")
			await get_tree().create_timer(KILL_TIMER).timeout
			print("KIIIIILL")
			self.queue_free()
			finished.emit()
	
	# move top once OPENED
	if ActiveContent > OpeningStates.SEALED:
		PackTop.position.y = lerpf(PackTop.position.y, -LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		PackTop.position.x = lerpf(PackTop.position.x, -LOWERED_PACK_HEIGHT*2, LERP_SPEED*delta)
	
	# move body once LOWERED and cards once displayed
	if ActiveContent >= OpeningStates.LOWERED:
		# move pack body
		PackBody.position.y = lerpf(PackBody.position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		# move content
		for i in range(min(ActiveContent, Content.size())):
			Content[i].position.y = lerpf(Content[i].position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
	
	# move everything once finished
	if ActiveContent > Content.size():
		position.y = lerpf(position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
	
	if position.y > 0:
		position.y = lerpf(position.y, 0, LERP_SPEED*delta)
