extends Control

signal pack_button_pressed
signal collection_button_pressed
signal play_button_pressed

@onready var PackTimer = $VBoxContainer/PackBar/TextureProgressBar
var TrueMin: float
var BarTarget: float
const LOADING_TEXTURE = preload("res://2_SCENES/MainZone/UI_textures/health_front.png") 
const LOADED_TEXTURE = preload("res://2_SCENES/MainZone/UI_textures/health_front_color.png")

func _process(delta: float) -> void:
	BarTarget = Time.get_unix_time_from_system()-TrueMin
	PackTimer.value = lerp(PackTimer.value, BarTarget, delta)
	if PackTimer.value == PackTimer.max_value: PackTimer.texture_over = LOADED_TEXTURE
	else: PackTimer.texture_over = LOADING_TEXTURE

func _on_pack_button_pressed() -> void: pack_button_pressed.emit()
func _on_collection_button_pressed() -> void: collection_button_pressed.emit()
func _on_play_button_pressed() -> void: play_button_pressed.emit()
func update_next_pack_timer(prev_pack_time: float, next_pack_time: float) -> void:
	TrueMin = prev_pack_time 
	PackTimer.max_value = next_pack_time-TrueMin
