extends Node3D
class_name Pack

signal finished

# content
var Rarity: DATA.Rarities
var Content: Array[Card]

# mesh parts
var PackTop := MeshInstance3D.new()
var PackBody := MeshInstance3D.new()

# consts
const LOWERED_PACK_HEIGHT: float = -5.0
const LERP_SPEED: float = 1.0
const KILL_TIMER: float = 1.5
const SLOWMODE_FINISHED_DIST: float = 1

# opening state
var IsSlowMode: bool
var Skipping: bool = false
var Ready: bool = true
var ContentMotion: int = ContentMotionStates.READY
enum ContentMotionStates {READY, MOVING, SKIPPING}
var ActiveContent: int = ActiveContentStates.SEALED
enum ActiveContentStates {SEALED = -2, OPEN = -1, LOWERED = 0}

func _init(R : DATA.Rarities, C : Array[Card], SlowMode : bool = false) -> void:
	# save information
	Rarity = R
	Content = C
	IsSlowMode = SlowMode
	
	# TODO: set pack texture
	
	# create pack top mesh
	PackTop.set_mesh(load("res://1_ASSETS/packs/pack_top_mesh.tres"))
	PackTop.set_name(DATA.Rarities.find_key(Rarity).to_lower()+"_pack_top")
	add_child(PackTop)
	
	# create pack body mesh
	PackBody.set_mesh(load("res://1_ASSETS/packs/pack_bottom_mesh.tres"))
	PackBody.set_name(DATA.Rarities.find_key(Rarity).to_lower()+"_pack_bottom")
	add_child(PackBody)
	
	# create cards
	for i in Content.size():
		var card: Card = Content[i]
		card.position.z -= 0.01 * i
		add_child(card)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Next"): 
		if !IsSlowMode or ActiveContent == ActiveContentStates.OPEN \
		or ContentMotion == ContentMotionStates.READY:
			ContentMotion = ContentMotionStates.MOVING
			ActiveContent += 1
			if ActiveContent == Content.size()+1:
				await get_tree().create_timer(KILL_TIMER).timeout
				self.queue_free()
				finished.emit()
		elif ContentMotion == ContentMotionStates.MOVING:
			ContentMotion = ContentMotionStates.SKIPPING
		elif ContentMotion == ContentMotionStates.SKIPPING:
			print("not ready")
	
	# move top once OPENED
	if ActiveContent > ActiveContentStates.SEALED:
		PackTop.position.y = lerpf(PackTop.position.y, -LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		PackTop.position.x = lerpf(PackTop.position.x, -LOWERED_PACK_HEIGHT*2, LERP_SPEED*delta)
	
	# move body once LOWERED and cards once displayed
	if ActiveContent >= ActiveContentStates.LOWERED:
		# move pack body
		PackBody.position.y = lerpf(PackBody.position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		# pack body slowmode ready check
		#if IsSlowMode and ActiveContent == ActiveContentStates.LOWERED:
			#if 1 and (PackBody.position.y - LOWERED_PACK_HEIGHT < SLOWMODE_FINISHED_DIST):
				#print("ready")
				#ContentMotion = ContentMotionStates.READY
		
		# move content
		for i in range(min(ActiveContent, Content.size())):
			Content[i].position.y = lerpf(Content[i].position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
			# pack content slowmode ready check
			#if IsSlowMode and ContentMotion == ContentMotionStates.SKIPPING:
				#if ActiveContent-1 == i and (Content[i].position.y - LOWERED_PACK_HEIGHT < SLOWMODE_FINISHED_DIST):
					#print("ready")
					#ContentMotion = ContentMotionStates.READY
				#else:
					#print("skipping")
					#Content[i].position.y = move_toward(Content[i].position.y, LOWERED_PACK_HEIGHT, 10*LERP_SPEED*delta)
		
		# slow mode check
		if IsSlowMode:
			var mover = PackBody if ActiveContent == ActiveContentStates.LOWERED else \
						PackTop if ActiveContent == ActiveContentStates.OPEN else \
						Content[ActiveContent-1] if ActiveContent <= Content.size() else PackTop
			# ready if progressed enough
			if (mover.position.y - LOWERED_PACK_HEIGHT < SLOWMODE_FINISHED_DIST):
				ContentMotion = ContentMotionStates.READY
			if ContentMotion != ContentMotionStates.MOVING:
				mover.position.y = move_toward(mover.position.y, LOWERED_PACK_HEIGHT, 10*LERP_SPEED*delta)

	
	# move everything once finished
	if ActiveContent > Content.size():
		position.y = lerpf(position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
	
	# bring packs in from top
	if position.y > 0:
		position.y = lerpf(position.y, 0, LERP_SPEED*delta)
