extends HBoxContainer
class_name PopUpConfirm

signal confirm
signal decline
signal pre_delete

func _init(message: String) -> void:
	var l_spacer := add_spacer(false)
	l_spacer.set_name("L_spacer")
	
	var center_panel := PanelContainer.new()
	center_panel.set_name("center_panel")
	#center_panel.add_theme_stylebox_override("normal", load("res://1_ASSETS/UI/Overrides/CollectionUI/PopUpConfirmationPanelOverride.tres")) 
	
	var center = VBoxContainer.new()
	center.set_name("center")
	center.size_flags_horizontal |= Control.SIZE_EXPAND_FILL
	
	var top_spacer := center.add_spacer(false)
	top_spacer.set_name("top_spacer")
	
	var label = Label.new()
	label.set_name("popup_message")
	label.set_text(message)
	center.add_child(label)
	
	var buttons = HBoxContainer.new()
	buttons.set_name("buttons")
	
	var l_button_spacer := buttons.add_spacer(false)
	l_button_spacer.set_name("L_button_spacer")
	var decline_button = Button.new()
	decline_button.set_text("decline?")
	decline_button.pressed.connect(func(): decline.emit(); queue_free())
	buttons.add_child(decline_button)
	var confirm_button = Button.new()
	confirm_button.set_text("confirm?")
	confirm_button.pressed.connect(func(): confirm.emit(); queue_free())
	buttons.add_child(confirm_button)
	var r_button_spacer := buttons.add_spacer(false)
	r_button_spacer.set_name("R_button_spacer")
	center.add_child(buttons)
	
	var bot_spacer := center.add_spacer(false)
	bot_spacer.set_name("bottom_spacer")
	
	center_panel.add_child(center)
	add_child(center_panel)
	
	var r_spacer := add_spacer(false)
	r_spacer.set_name("R_spacer")
	
	set_name("confirmation_popup")


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		pre_delete.emit()
