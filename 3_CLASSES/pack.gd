extends Node3D
class_name Pack

signal finished

# consts
const PARTICLES = preload("res://1_ASSETS/cards/animations/merge_particles.tscn")
const LOWERED_PACK_HEIGHT: float = -4.5
const RAISED_CONTENT_HEIGHT: float = 4.5
const LERP_SPEED: float = 1.0
const SKIP_SPEED_MULT: float = 15.0
const KILL_TIMER: float = 1.5
const SLOWMODE_FINISHED_DIST: float = 1

const PACKCAM_STARTING_POS := Vector3(0, 0.5, 15)
const PACKCAM_VIEWING_POS := Vector3(0, -1.5, 8.5)
const PACKCAM_STARTING_ANGLE := Vector3(-1.1, 0, 0)
const PACKCAM_VIEWING_ANGLE := Vector3(4.4, 0, 0)

var PackCam := Camera3D.new()
var PackTop := MeshInstance3D.new()
var PackBody := MeshInstance3D.new()
var Holder: ContentHolder

# content
var Rarity: DATA.Rarities
var Content: Array[Card]
var PairedContent: Array[PlayablePair]
var RarePullEffect: Callable

# opening state
var IsReady: bool = true
var IsSkipping: bool = false
var ActiveContent: int = ActiveContentStates.SEALED
enum ActiveContentStates {SEALED = -2, OPEN = -1}#, LOWERED = 0}

func _init(R : DATA.Rarities, C : Array[Card]) -> void:
	# save information
	Rarity = R
	Content = C
	var plain_name: String = DATA.Rarities.find_key(Rarity).to_lower()+"_pack"
	
	# init cam, these are the same settings as the main cam (at time of creation lol)
	PackCam.set_current(true)
	PackCam.set_position(PACKCAM_STARTING_POS)
	PackCam.set_rotation_degrees(PACKCAM_STARTING_ANGLE)
	PackCam.set_fov(35)
	PackCam.set_name(plain_name+"_camera")
	add_child(PackCam)
	
	# TODO: set pack texture
	var mat: StandardMaterial3D = DATA.create_rarity_material(Rarity)
	
	# create pack top mesh
	PackTop.set_mesh(load("res://1_ASSETS/packs/pack_top_mesh.tres"))
	PackTop.set_name(plain_name+"_top")
	PackTop.set_surface_override_material(0, mat)
	add_child(PackTop)
	
	# create pack body mesh
	PackBody.set_mesh(load("res://1_ASSETS/packs/pack_bottom_mesh.tres"))
	PackBody.set_name(plain_name+"_bottom")
	PackBody.set_surface_override_material(0, mat)
	add_child(PackBody)
	
	# create content holder and fill
	Holder = ContentHolder.new(plain_name)
	Holder.set_name("ContentHolder")
	add_child(Holder)
	
	# create cards
	for i in Content.size():
		var card: Card = Content[i]
		card.position.z -= 0.01 * i
		
		card.AnimationComplete.connect(handle_animation_complete)
		
		Holder.add_child(card)


func _process(delta: float) -> void:
	# bring packs in from top
	if ActiveContent < Content.size():
		#position.y = lerpf(position.y, 0, LERP_SPEED*delta)
		PackCam.position = lerp(PackCam.position, PACKCAM_VIEWING_POS, LERP_SPEED*delta)
		PackCam.rotation_degrees = lerp(PackCam.rotation_degrees, PACKCAM_VIEWING_ANGLE, LERP_SPEED*delta)
		# move pack body
		PackBody.position.y = lerpf(PackBody.position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		Holder.position.y = lerpf(Holder.position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		# move everything once finished
	else:
		#position.y = lerpf(position.y, 2*LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		PackCam.position = lerp(PackCam.position, PACKCAM_STARTING_POS, 3*LERP_SPEED*delta)
		PackCam.rotation_degrees = lerp(PackCam.rotation_degrees, PACKCAM_STARTING_ANGLE, 3*LERP_SPEED*delta)
		# move pack body
		PackBody.position.y = lerpf(PackBody.position.y, 2*LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		Holder.position.y = lerpf(Holder.position.y, 2*LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		# kill pack once lowered
		if PackBody.position.y - 2*LOWERED_PACK_HEIGHT < SLOWMODE_FINISHED_DIST:
			self.queue_free()
			finished.emit()
	
	# move top once OPENED
	if ActiveContent > ActiveContentStates.SEALED:
		if PackTop:
			PackTop.position.y = lerpf(PackTop.position.y, -LOWERED_PACK_HEIGHT*3, LERP_SPEED*delta)
			#PackCam.position.z = lerpf(PackCam.position.z)
			#PackTop.position.x = lerpf(PackTop.position.x, -LOWERED_PACK_HEIGHT*2, LERP_SPEED*delta)
			if position.distance_to(PackTop.position) > -LOWERED_PACK_HEIGHT*2:
				PackTop.queue_free()
	elif PackTop:
		PackTop.position.y = lerpf(PackTop.position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
	
	
	# when a Next comes in
	if Input.is_action_just_pressed("Next"): 
		# start the next mover moving
		if IsReady:
			IsSkipping = false
			IsReady = false
			ActiveContent += 1
			
			if ActiveContent == ActiveContentStates.OPEN:
				IsReady = true
			if ActiveContent >= 0 and ActiveContent < Content.size():
				Content[ActiveContent].play_anim("moves/SecondaryReveal" if ActiveContent%2 else "moves/PrimaryReveal")
		# or begin skipping
		elif !IsReady:
			IsSkipping = false#true

func handle_animation_complete(anim_name: String):
			if  anim_name == "moves/PrimaryReveal":
				#IsReady = true
				ActiveContent += 1
				Content[ActiveContent].play_anim("moves/SecondaryReveal" if ActiveContent%2 else "moves/PrimaryReveal")
			elif anim_name == "moves/SecondaryReveal":
				Content[ActiveContent].play_anim("moves/SecondaryMerge")
				Content[ActiveContent-1].play_anim("moves/PrimaryMerge")
			elif anim_name == "moves/SecondaryMerge":
				# created PairedContent
				var pair := PlayablePair.create_from_two_cards(Content[ActiveContent-1], Content[ActiveContent])
				pair.AnimationComplete.connect(handle_animation_complete)
				pair.position.y = -LOWERED_PACK_HEIGHT
				pair.play_anim("moves/PairSpin")
				
				# manage old and new content
				Holder.add_child(pair)
				PairedContent.append(pair)
				Content[ActiveContent].queue_free()
				Content[ActiveContent-1].queue_free()
				
				var particles = load("res://1_ASSETS/cards/animations/merge_particles.tscn").instantiate()
				pair.add_child(particles)
				particles.emitting = true
				await get_tree().create_timer(0.05).timeout
				particles.emitting = false
			elif anim_name == "moves/PairSpin":
				var rand = floor(3*RNG.random_value())
				PairedContent[floor(ActiveContent/2)].play_anim("moves/PairLeaveUp" if rand == 0 else
																"moves/PairLeaveLeft" if rand == 0 else
																"moves/PairLeaveRight")
			elif anim_name == "moves/PairLeaveUp" or \
				 anim_name == "moves/PairLeaveLeft" or \
				 anim_name == "moves/PairLeaveRight":
					PairedContent[floor(ActiveContent/2)].set_visible(false)
					IsReady = true
				

#func _process(delta: float) -> void:
	## bring packs in from top
	#if position.y > 0:
		#position.y = lerpf(position.y, 0, LERP_SPEED*delta)
	#
	## move top once OPENED
	#if ActiveContent > ActiveContentStates.SEALED:
		#PackTop.position.y = lerpf(PackTop.position.y, -LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		#PackTop.position.x = lerpf(PackTop.position.x, -LOWERED_PACK_HEIGHT*2, LERP_SPEED*delta)
	#
	## move body once LOWERED and cards once displayed
	#if ActiveContent >= ActiveContentStates.LOWERED:
		## move pack body
		#PackBody.position.y = lerpf(PackBody.position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		## move content
		#for i in range(min(ActiveContent, Content.size())):
			#Content[i].position.y = lerpf(Content[i].position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
	#
	## move everything once finished
	#if ActiveContent > Content.size():
		#position.y = lerpf(position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		## kill pack once lowered
		#if position.y - LOWERED_PACK_HEIGHT < SLOWMODE_FINISHED_DIST:
			#self.queue_free()
			#finished.emit()
	#
	## select proper moving part, if null, it is the entire pack
	#var mover = PackTop if ActiveContent == ActiveContentStates.OPEN else \
				#PackBody if ActiveContent == ActiveContentStates.LOWERED else \
				#Content[ActiveContent-1] if ActiveContent <= Content.size() and ActiveContent >= 0 \
				#else null
	#
	## slow mode check to re-ready if progressed enough
	#if mover: # anything besides the pack itself
		## move the content faster if skipping
		#if IsSkipping: mover.position.y = move_toward(mover.position.y, LOWERED_PACK_HEIGHT, SKIP_SPEED_MULT*LERP_SPEED*delta)
		## ready for next motion if within SLOWMODE_FINISHED_DIST of LOWERED_PACK_HEIGHT
		#if (mover.position.y - LOWERED_PACK_HEIGHT < SLOWMODE_FINISHED_DIST) or mover == PackTop: IsReady = true
	#else: # the pack itself
		## move the pack faster if skipping
		#if IsSkipping:
			## move from above to 0, or from 0 to LOWERED_PACK_HEIGHT
			#if ActiveContent > Content.size(): position.y = move_toward(position.y, LOWERED_PACK_HEIGHT, SKIP_SPEED_MULT*LERP_SPEED*delta)
			#else: position.y = move_toward(position.y, 0, SKIP_SPEED_MULT*LERP_SPEED*delta)
		## ready for next motion if within SLOWMODE_FINISHED_DIST of 0, only if starting
		#if ActiveContent <= ActiveContentStates.SEALED and position.y < SLOWMODE_FINISHED_DIST: IsReady = true
	#
	#
	## when a Next comes in
	#if Input.is_action_just_pressed("Next"): 
		## start the next mover moving
		#if IsReady:
			#IsSkipping = false
			#IsReady = false
			#ActiveContent += 1
		## or begin skipping
		#elif !IsReady:
			#IsSkipping = true
