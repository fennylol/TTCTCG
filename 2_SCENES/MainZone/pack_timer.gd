extends VBoxContainer
class_name PackTimerNode

@onready var PackTimer: TextureProgressBar = $PackTimerBarARContainer/PackTimerBar
@onready var PackTimerLabel: Label = $PackTimerBarARContainer/PackTimerBar/TimerLabel

const UNDER_TEX = preload("res://2_SCENES/MainZone/UI_textures/large/empty.png")
const FIRST_LOADING = preload("res://2_SCENES/MainZone/UI_textures/large/half_full.png")
const SECOND_LOADING = preload("res://2_SCENES/MainZone/UI_textures/large/full.png")

func _ready() -> void: PackTimer.max_value = ContentCollection.NEXT_PACK_UNIX_TIME_OFFSET

func _process(delta: float) -> void:
	var time_till_next_charge: float = COLLECTION.next_pack_timestamp-Time.get_unix_time_from_system()
	var time_till_charge_after: float = COLLECTION.pack_after_that_timestamp-Time.get_unix_time_from_system()
	
	var bar_prog: float = ContentCollection.NEXT_PACK_UNIX_TIME_OFFSET-(time_till_next_charge if time_till_next_charge > 0.0 else time_till_charge_after)
	PackTimer.value = lerp(PackTimer.value, bar_prog, delta) if bar_prog > PackTimer.value else bar_prog
	
	var time_string: String = Time.get_time_string_from_unix_time(int(time_till_next_charge))  if time_till_next_charge  > 0.0 else \
							  Time.get_time_string_from_unix_time(int(time_till_charge_after)) if time_till_charge_after > 0.0 else ""
	PackTimerLabel.text = time_string
	
	if time_till_next_charge > 0.0:
		PackTimer.texture_under = UNDER_TEX
		PackTimer.texture_progress = FIRST_LOADING
		PackTimer.texture_over = null
	else:
		PackTimer.texture_under = FIRST_LOADING
		PackTimer.texture_progress = SECOND_LOADING
		PackTimer.texture_over = null
