extends Control
class_name PackUINode

signal expansion_selected(ExpansionID: DATA.ExpansionIDs, single_pack: bool)
signal store_button_pressed
signal back_button_pressed

@onready var ExpansionButtonContainer: GridContainer = $VBoxContainer/Body/ExpansionButtonPadding/ExpansionButtons
@onready var ExpansionBoosterButtonContainer: GridContainer = $VBoxContainer/Body/ExpansionButtonPadding/ExpansionBoosterButtons
@onready var TimerChargeCounter: Label = $VBoxContainer/Body/StoreButtonPadding/TimerChargeLabel

func _on_back_button_pressed()       -> void: back_button_pressed.emit()
func _on_store_time_button_pressed() -> void: store_button_pressed.emit()
func _on_odds_button_pressed()       -> void: 
	var msg: String = ""
	for exp_id in DATA.ExpansionIDs:
		msg += exp_id + "\n"
		var evs = DATA.get_expansion_EVs(DATA.ExpansionIDs.get(exp_id))
		msg += "├┬─ Expected Values:\n"
		msg += "││  a PACK should have approximately\n"
		msg += "│╰┬─ " + str(snappedf(DATA.array_sum(evs), 0.001)).lpad(4, " ") + " cards.\n"
		for rarity in DATA.Rarities: 
			msg += "│ ╰─ " if DATA.Rarities.get(rarity) == DATA.Rarities.HOLY_MOLY else "│ ├─ " 
			msg += str(snappedf(evs[DATA.Rarities.get(rarity)], 0.001)).lpad(4, " ") + " of which should be " + rarity.replace("_", " ") + "\n"
		msg += "│\n"
		msg += "╰┬─ PACK AND CONTENT ODDS:\n"
		msg += " │  a PACK has a\n"
		
		var pack_odds = DATA.get_pack_rarity_odds(DATA.ExpansionIDs.get(exp_id))
		for rarity in DATA.Rarities: 
			msg += " ╰┬─ " if DATA.Rarities.get(rarity) == DATA.Rarities.HOLY_MOLY else " ├┬─ "
			msg += str(snappedf(pack_odds[DATA.Rarities.get(rarity)]*100, 0.1)).lpad(4, " ") + "% chance to be " + rarity.replace("_", " ") + "\n"
			msg += "  │  " if DATA.Rarities.get(rarity) == DATA.Rarities.HOLY_MOLY else " ││  "
			msg += "from which a CARD has a\n"
			
			var content_odds = DATA.get_content_rarity_odds(DATA.ExpansionIDs.get(exp_id), DATA.Rarities.get(rarity))
			for content_rarity in DATA.Rarities:
				msg += "  "   if DATA.Rarities.get(rarity)         == DATA.Rarities.HOLY_MOLY else " │"
				msg += " ╰─ " if DATA.Rarities.get(content_rarity) == DATA.Rarities.HOLY_MOLY else "╰┬─ " if DATA.Rarities.get(content_rarity) == DATA.Rarities.COMMON else " ├─ "
				msg += str(snappedf(content_odds[DATA.Rarities.get(content_rarity)]*100, 0.1)).lpad(4, " ") + "% chance to be " + content_rarity.replace("_", " ") + "\n"
			msg +="\n\n" if DATA.Rarities.get(rarity) == DATA.Rarities.HOLY_MOLY else " │\n" 
	var title: String = "PER-EXPANSION STATISTICAL DATA:\n(please note that odds displayed here are rounded for\nvisual clarity and may not add up exactly to 100%)"
	var popup = PopUpLongDialog.new(title, msg, 40)
	LOGGER.post_msg_board_node(popup)
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
