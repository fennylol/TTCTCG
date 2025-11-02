extends Control
class_name PackUINode

signal expansion_selected(ExpansionID: DATA.ExpansionIDs, single_pack: bool)
signal store_button_pressed
signal back_button_pressed

@onready var ExpansionButtonContainer: GridContainer = $VBoxContainer/Body/ExpansionButtonPadding/ExpansionButtons
@onready var ExpansionBoosterButtonContainer: GridContainer = $VBoxContainer/Body/ExpansionButtonPadding/ExpansionBoosterButtons
@onready var TimerChargeCounter: Label = $VBoxContainer/TopBar/TimerChargeLabel

func _on_back_button_pressed()       -> void: back_button_pressed.emit()
func _on_store_time_button_pressed() -> void: store_button_pressed.emit()
func _update_timer_charge_count()    -> void: TimerChargeCounter.text = str(COLLECTION.timer_charges) + " Timer Charges"
func _ready() -> void:
	for expansionID in DATA.ExpansionIDs:
		var expansion_button = Button.new()
		expansion_button.set_name(expansionID.to_lower()+"_button")
		expansion_button.set_text(expansionID)
		expansion_button.size_flags_horizontal |= Control.SIZE_EXPAND
		expansion_button.size_flags_vertical   |= Control.SIZE_EXPAND
		expansion_button.pressed.connect(func(): expansion_selected.emit(DATA.ExpansionIDs.get(expansionID), true))
		ExpansionButtonContainer.add_child(expansion_button)
		ExpansionButtonContainer.move_child(expansion_button, 0)
		
		var expansion_booster_button = Button.new()
		expansion_booster_button.set_name(expansionID.to_lower()+"_booster_button")
		expansion_booster_button.set_text(expansionID+"\nBOOSTER")
		expansion_booster_button.size_flags_horizontal |= Control.SIZE_EXPAND
		expansion_booster_button.size_flags_vertical   |= Control.SIZE_EXPAND
		expansion_booster_button.pressed.connect(func(): expansion_selected.emit(DATA.ExpansionIDs.get(expansionID), false))
		ExpansionBoosterButtonContainer.add_child(expansion_booster_button)
		ExpansionBoosterButtonContainer.move_child(expansion_booster_button, 0)
