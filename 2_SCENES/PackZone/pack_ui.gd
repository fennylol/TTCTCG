extends Control
class_name PackUINode

signal expansion_selected(ExpansionID: DATA.ExpansionIDs)
signal back_button_pressed
@onready var ExpansionButtonContainer: GridContainer = $VBoxContainer/Body/ExpansionButtonPadding/ExpansionButtons

func _on_back_button_pressed() -> void: back_button_pressed.emit()
func _ready()                  -> void:
	for expansionID in DATA.ExpansionIDs:
		var expansion_button = Button.new()
		expansion_button.name = expansionID.to_lower()+"_button"
		expansion_button.text = expansionID
		expansion_button.size_flags_horizontal |= Control.SIZE_EXPAND
		expansion_button.size_flags_vertical   |= Control.SIZE_EXPAND
		expansion_button.pressed.connect(func(): expansion_selected.emit(DATA.ExpansionIDs.get(expansionID)))
		ExpansionButtonContainer.add_child(expansion_button)
		ExpansionButtonContainer.move_child(expansion_button, 0)
