extends Control

signal pack_button_pressed
signal collection_button_pressed
signal play_button_pressed

@onready var PackTimer = $VBoxContainer/PackBar/TextureProgressBar
var NextPack: float
var PackAfter: float
var BarTarget: float

const UNDER_TEX = preload("res://2_SCENES/MainZone/UI_textures/health_prog_loss.png")
const FIRST_LOADING = preload("res://2_SCENES/MainZone/UI_textures/health_progress.png")

const SECOND_LOADING = preload("res://2_SCENES/MainZone/UI_textures/health_front_color.png")

#const LOADING_FIRST_COVER = preload("res://2_SCENES/MainZone/UI_textures/health_front.png") 
#const LOADED_FIRST_COVER = preload("res://2_SCENES/MainZone/UI_textures/health_front_color.png")
#const LOADED_SECOND_COVER = preload("res://2_SCENES/MainZone/UI_textures/stam_front_color.png")
#
#const LOADING_FIRST_UNDER = preload("res://2_SCENES/MainZone/UI_textures/health_prog_loss.png")
#const LOADING_FIRST_BAR = preload("res://2_SCENES/MainZone/UI_textures/health_progress.png") 
#const LOADING_SECOND_BAR = preload("res://2_SCENES/MainZone/UI_textures/stam_prog.png") 



func _ready() -> void: 
	PackTimer.max_value = ContentCollection.NEXT_PACK_UNIX_TIME_OFFSET
	

func _process(delta: float) -> void:
	var time_till_next_charge: float = NextPack-Time.get_unix_time_from_system()
	var time_till_charge_after: float = PackAfter-Time.get_unix_time_from_system()
	
	var bar_prog: float = ContentCollection.NEXT_PACK_UNIX_TIME_OFFSET-(time_till_next_charge if time_till_next_charge > 0.0 else time_till_charge_after)
	PackTimer.value = lerp(PackTimer.value, bar_prog, delta)
	if bar_prog < PackTimer.value: PackTimer.value = bar_prog
	
	if time_till_next_charge > 0.0:
		PackTimer.texture_under = UNDER_TEX
		PackTimer.texture_progress = FIRST_LOADING
		PackTimer.texture_over = null
	else:
		PackTimer.texture_under = FIRST_LOADING
		PackTimer.texture_progress = SECOND_LOADING
		PackTimer.texture_over = null
	
	#BarTarget = min(Time.get_unix_time_from_system()-TrueMin, 2*ContentCollection.NEXT_PACK_UNIX_TIME_OFFSET)
	#var true_target: float = BarTarget if BarTarget < ContentCollection.NEXT_PACK_UNIX_TIME_OFFSET else BarTarget-ContentCollection.NEXT_PACK_UNIX_TIME_OFFSET
	#
	#update_pack_timer_visuals()

# =============== #
# signal emission #
# =============== #
func _on_pack_button_pressed() -> void: pack_button_pressed.emit()
func _on_collection_button_pressed() -> void: collection_button_pressed.emit()
func _on_play_button_pressed() -> void: play_button_pressed.emit()
# ============== #
# call reception #
# ============== #
func _recieve_pack_timer(next_pack: float, pack_after: float) -> void: 
	NextPack = next_pack
	PackAfter = pack_after
	#PackTimer.value = Time.get_unix_time_from_system()-NextPack
	#update_pack_timer_visuals()
