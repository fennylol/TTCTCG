extends Control
class_name MainUINode

signal pack_zone_button_pressed
signal collection_zone_button_pressed
signal game_zone_button_pressed

# =============== #
# signal emission #
# =============== #
func _on_pack_zone_button_pressed()       -> void: pack_zone_button_pressed.emit()
func _on_collection_zone_button_pressed() -> void: collection_zone_button_pressed.emit()
func _on_game_zone_button_pressed()       -> void: game_zone_button_pressed.emit()
