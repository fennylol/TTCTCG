extends Control

signal back_button_pressed
signal DEBUG_reset_button_pressed

func _on_back_button_pressed() -> void: back_button_pressed.emit()
func _on_reset_button_pressed() -> void: DEBUG_reset_button_pressed.emit()
