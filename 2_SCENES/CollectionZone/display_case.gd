extends Node3D
class_name DisplayCase

var display_stand: RigidBody3D
var cruising_speed: float = PI/5
var event: InputEventScreenDrag

func _init(card: Card) -> void:
	var rb = RigidBody3D.new()
	display_stand = rb
	rb.set_gravity_scale(0.0)
	rb.set_mass(100.0)
	rb.set_name("display_stand")
	add_child(rb)
	set_name(card.Name+"display_case")
	if card.get_parent(): card.reparent(rb, false)
	else:                 rb.add_child(card)
func _ready() -> void:
	display_stand.angular_damp_mode = RigidBody3D.DAMP_MODE_REPLACE
	display_stand.angular_damp = 0.0
func _input(_event: InputEvent) -> void:
	if not is_visible_in_tree(): return
	elif _event is InputEventScreenDrag: event = _event
func _process(delta: float) -> void:
	# TODO: make this settle on one side or the other.
	if not is_visible_in_tree()                            : return
	elif event                                             : display_stand.apply_torque(Vector3(0, event.screen_velocity.x * delta, 0))
	elif display_stand.angular_velocity.y > cruising_speed : display_stand.angular_velocity.y = move_toward(display_stand.angular_velocity.y, cruising_speed, abs(display_stand.angular_velocity.y-cruising_speed)*delta)
	elif display_stand.angular_velocity.y < -cruising_speed: display_stand.angular_velocity.y = move_toward(display_stand.angular_velocity.y, -cruising_speed, abs(display_stand.angular_velocity.y-cruising_speed)*delta)
	else                                                   : display_stand.angular_velocity.y = move_toward(display_stand.angular_velocity.y, 0, delta)
	event = null
