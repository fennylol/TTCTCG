extends Node3D
class_name Pack

signal finished

# consts
const LOWERED_PACK_HEIGHT: float = -5.0
const LERP_SPEED: float = 1.0
const SKIP_SPEED_MULT: float = 15.0
const KILL_TIMER: float = 1.5
const SLOWMODE_FINISHED_DIST: float = 1
var PackTop := MeshInstance3D.new()
var PackBody := MeshInstance3D.new()

# content
var Rarity: DATA.Rarities
var Content: Array[Card]
var RarePullEffect: Callable

# opening state
var IsSlowMode: bool
var IsReady: bool = false
var IsRarePullEffectPlaying: bool = false
var IsSkipping: bool = false
var ActiveContent: int = ActiveContentStates.SEALED
enum ActiveContentStates {SEALED = -2, OPEN = -1, LOWERED = 0}

func _init(R : DATA.Rarities, C : Array[Card], SlowMode : bool = true) -> void:
	# save information
	Rarity = R
	Content = C
	IsSlowMode = SlowMode
	
	var plain_name: String = DATA.Rarities.find_key(Rarity).to_lower()+"_pack"
	
	# TODO: set pack texture
	
	# create pack top mesh
	PackTop.set_mesh(load("res://1_ASSETS/packs/pack_top_mesh.tres"))
	PackTop.set_name(plain_name+"_top")
	add_child(PackTop)
	
	# create pack body mesh
	PackBody.set_mesh(load("res://1_ASSETS/packs/pack_bottom_mesh.tres"))
	PackBody.set_name(plain_name+"_bottom")
	add_child(PackBody)
	
	var holder = ContentHolder.new(plain_name)
	holder.set_name("ContentHolder")
	add_child(holder)
	# create cards
	for i in Content.size():
		var card: Card = Content[i]
		card.position.z -= 0.01 * i
		
		var done = func(anim_name: String):
			print(card.Name, "'s ", anim_name, " done")
		
		card.AnimationComplete.connect(done)
		
		holder.add_child(card)


func _process(delta: float) -> void:
	# bring packs in from top
	if position.y > 0:
		position.y = lerpf(position.y, 0, LERP_SPEED*delta)
	
	# move top once OPENED
	if ActiveContent > ActiveContentStates.SEALED:
		PackTop.position.y = lerpf(PackTop.position.y, -LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		PackTop.position.x = lerpf(PackTop.position.x, -LOWERED_PACK_HEIGHT*2, LERP_SPEED*delta)
	
	# move body once LOWERED and cards once displayed
	if ActiveContent >= ActiveContentStates.LOWERED:
		# move pack body
		PackBody.position.y = lerpf(PackBody.position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		# move content
		for i in range(min(ActiveContent, Content.size())):
			Content[i].position.y = lerpf(Content[i].position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
	
	# move everything once finished
	if ActiveContent > Content.size():
		position.y = lerpf(position.y, LOWERED_PACK_HEIGHT, LERP_SPEED*delta)
		# kill pack once lowered
		if position.y - LOWERED_PACK_HEIGHT < SLOWMODE_FINISHED_DIST:
			self.queue_free()
			finished.emit()
	
	# slow mode check to re-ready if progressed enough
	if IsSlowMode:
		# select proper moving part, if null, it is the entire pack
		var mover = PackTop if ActiveContent == ActiveContentStates.OPEN else \
					PackBody if ActiveContent == ActiveContentStates.LOWERED else \
					Content[ActiveContent-1] if ActiveContent <= Content.size() and ActiveContent >= 0 \
					else null
		
		if mover: # anything besides the pack itself
			# move the content faster if skipping
			if IsSkipping: mover.position.y = move_toward(mover.position.y, LOWERED_PACK_HEIGHT, SKIP_SPEED_MULT*LERP_SPEED*delta)
			# ready for next motion if within SLOWMODE_FINISHED_DIST of LOWERED_PACK_HEIGHT
			if (mover.position.y - LOWERED_PACK_HEIGHT < SLOWMODE_FINISHED_DIST) or mover == PackTop: IsReady = true
		else: # the pack itself
			# move the pack faster if skipping
			if IsSkipping:
				# move from above to 0, or from 0 to LOWERED_PACK_HEIGHT
				if ActiveContent > Content.size(): position.y = move_toward(position.y, LOWERED_PACK_HEIGHT, SKIP_SPEED_MULT*LERP_SPEED*delta)
				else: position.y = move_toward(position.y, 0, SKIP_SPEED_MULT*LERP_SPEED*delta)
			# ready for next motion if within SLOWMODE_FINISHED_DIST of 0, only if starting
			if ActiveContent <= ActiveContentStates.SEALED and position.y < SLOWMODE_FINISHED_DIST: IsReady = true
		
	if IsRarePullEffectPlaying:
		IsRarePullEffectPlaying = RarePullEffect.call(delta)
	else:
		# when a Next comes in
		if Input.is_action_just_pressed("Next") or (IsSlowMode and Input.is_action_pressed("Skip")): 
			# start the next mover moving
			if !IsSlowMode or IsReady:
				IsSkipping = false
				IsReady = false
				ActiveContent += 1
				# check for rare content
				#if ActiveContent < Content.size() and ActiveContent > 0 and \
				   #Content[ActiveContent].Rarity >= DATA.Rarities.RARE:
					#print("RARE CARD")
					#IsRarePullEffectPlaying = true
			# or begin skipping
			elif !IsReady:
				IsSkipping = true
		if Input.is_action_pressed("Skip") and IsSlowMode: IsSkipping = true
		elif Input.is_action_just_released("Skip") and IsSlowMode: IsSkipping = false
