extends Node3D
class_name ContentHolder

signal clicked

#const ROT_SPEED = 5
#var RotationLocked: bool = false
#var FollowingMouse: bool = false
#
#var DragBegin := Vector3.ZERO
#
#var MovementBegin := Vector3.ZERO
#var MovementEnd := Vector3.ZERO

var InputWasClick = false



func _init(Name: String = "content_holder", ContentWidth: float = Card.CARD_WIDTH, ContentHeight: float = Card.CARD_HEIGHT) -> void:
	var ch_area := Area3D.new()
	var cha_collider := CollisionShape3D.new()
	var chac_shape := BoxShape3D.new()
	chac_shape.set_size(Vector3(ContentWidth, ContentHeight, 0.1))
	cha_collider.set_shape(chac_shape) 
	ch_area.add_child(cha_collider)
	add_child(ch_area)
	
	set_name(Name)
	ch_area.set_name(Name+"_area")
	cha_collider.set_name(Name+"_collider")


func InOutQuadBlend(t: float):
	if(t <= 0.5):
		return 2.0 * t * t;
	t -= 0.5;
	return 2.0 * t * (1.0 - t) + 0.5;

func _input(event: InputEvent) -> void: if event is InputEventScreenDrag: InputWasClick = false
func _process(_delta: float) -> void:
	#if MovementBegin != MovementEnd:
		#var move_dist: float = MovementEnd.distance_to(MovementBegin)
		#var moved_dist: float = position.distance_to(MovementBegin)
		#var p: float = (moved_dist/move_dist)+delta
		#
		#var move_vec: Vector3 = MovementEnd-MovementBegin
		##var proportion = InOutQuadBlend(p+delta)
		#position = p*move_vec
		#if p >= 0.995:
			#MovementBegin = position
			#MovementEnd = position
	if Input.is_action_just_pressed("Next") and is_visible_in_tree():
		InputWasClick = true
	if InputWasClick and Input.is_action_just_released("Next") and is_visible_in_tree():
		var cam = get_viewport().get_camera_3d()
		var mouse_pos = get_viewport().get_mouse_position()

		var ray_start = cam.project_ray_origin(mouse_pos)
		var ray_end = ray_start + cam.project_ray_normal(mouse_pos) * 20
		var world3d : World3D = get_world_3d()
		var space_state = world3d.direct_space_state
		
		if space_state == null:
			return
		
		var query := PhysicsRayQueryParameters3D.create(ray_start, ray_end)
		query.collide_with_areas = true
		
		var result = space_state.intersect_ray(query)
		if result and result.has("collider"):
			if result.collider.get_parent() == self and not _check_node_blocks_mouse(get_tree().root, mouse_pos):
				clicked.emit()
				#DragBegin = result.position
				#FollowingMouse = !RotationLocked
		#
	#elif Input.is_action_just_released("Next"):
		#FollowingMouse = false
	##if Input.is_action_just_pressed("Next") and get_node3D_from_click() == self:
		##FollowingMouse = !RotationLocked
		##DragBegin = global_position
	##elif Input.is_action_just_released("Next"):
		##FollowingMouse = false
	#
	#if FollowingMouse:
		#var cam = get_viewport().get_camera_3d()
		#var mouse_pos = get_viewport().get_mouse_position()
		#var ray_start = cam.project_ray_origin(mouse_pos)
		#var dist = (ray_start - global_position).length()
		#var ray_end = ray_start + cam.project_ray_normal(mouse_pos) * dist * 0.8
		#
		#var dir = (ray_end - DragBegin).normalized()
		#var angle = atan2(dir.x, dir.z)
		#rotation.y = lerpf(rotation.y, angle, 4*ROT_SPEED*delta)
		#angle = -atan2(dir.y, dir.z)
		#rotation.x = lerpf(rotation.x, angle, 4*ROT_SPEED*delta)
	#else:
		#rotation.x = lerpf(rotation.x, 0, delta*ROT_SPEED)
		#rotation.y = lerpf(rotation.y, 0, delta*ROT_SPEED)

func get_node3D_from_click() -> Node3D:
	var cam = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()

	var ray_start = cam.project_ray_origin(mouse_pos)
	var ray_end = ray_start + cam.project_ray_normal(mouse_pos) * 20
	var world3d : World3D = get_world_3d()
	var space_state = world3d.direct_space_state
	
	if space_state == null:
		return
	
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	query.collide_with_areas = true
	
	var result = space_state.intersect_ray(query)
	if result and result.has("collider"):
		var clicked_on = result.collider
		return clicked_on.get_parent()
	else: return null

func _check_node_blocks_mouse(node: Node, pos: Vector2) -> bool:
	if node is Control and node.is_visible_in_tree() and node.mouse_filter == Control.MOUSE_FILTER_STOP:
		if node.get_global_rect().has_point(pos):
			print(node.get_path(), " is blocking")
			return true
	
	for child in node.get_children():
		if _check_node_blocks_mouse(child, pos):
			return true
	
	return false
