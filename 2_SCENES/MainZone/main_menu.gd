extends Control

signal pack_button_pressed
signal collection_button_pressed

func _on_pack_button_pressed() -> void: pack_button_pressed.emit()
func _on_collection_button_pressed() -> void: collection_button_pressed.emit()
