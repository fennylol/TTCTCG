extends HBoxContainer
class_name DeckButton

signal selected
signal deleted

const X_ICON = preload("res://1_ASSETS/UI/X.png")

func _init(deck: Deck, icon: Texture2D, AddDeleteButton: bool = true) -> void:
	name = deck.Name.replace(" ", "_").to_lower() + "_list"
	
	var deck_button := TextureButton.new()
	deck_button.name = "edit_" + deck.Name.replace(" ", "_").to_lower() + "_button"
	deck_button.texture_normal = icon
	deck_button.size_flags_horizontal |= Control.SIZE_EXPAND
	deck_button.pressed.connect(selected.emit)
	add_child(deck_button)
	
	var deck_label := Label.new()
	deck_label.name = deck.Name.replace(" ", "_").to_lower() + "_label"
	deck_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	deck_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	deck_label.set_anchors_preset(Control.PRESET_FULL_RECT)
	deck_label.text = deck.Name + ("   " if AddDeleteButton else "            ")
	deck_button.add_child(deck_label)
	
	if AddDeleteButton:
		var delete_button := TextureButton.new()
		delete_button.name = "delete_" + deck.Name.replace(" ", "_").to_lower() + "_button"
		delete_button.texture_normal = X_ICON
		delete_button.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		delete_button.pressed.connect(deleted.emit)
		add_child(delete_button)
