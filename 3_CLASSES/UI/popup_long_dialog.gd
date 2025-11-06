extends PopUp
class_name PopUpLongDialog

enum ReturnCodes { DONE }

func _init(title: String, message: String, lines_to_show: int = 10, margins: Array[int] = DEFAULT_MARGINS) -> void:
	super._init(margins)
	
	var l_spacer := add_spacer(false)
	l_spacer.set_name("L_spacer")
	
	var center_panel := PanelContainer.new()
	center_panel.set_name("center_panel")
	add_child(center_panel)
	
	var margin_container := MarginContainer.new()
	margin_container.set_name("margin_container")
	margin_container.add_theme_constant_override("margin_top",    margins[MARGIN_DIRECTIONS.TOP])
	margin_container.add_theme_constant_override("margin_left",   margins[MARGIN_DIRECTIONS.LEFT])
	margin_container.add_theme_constant_override("margin_bottom", margins[MARGIN_DIRECTIONS.BOTTOM])
	margin_container.add_theme_constant_override("margin_right",  margins[MARGIN_DIRECTIONS.RIGHT])
	center_panel.add_child(margin_container)
	
	var center = VBoxContainer.new()
	center.set_name("center")
	center.size_flags_horizontal |= Control.SIZE_EXPAND_FILL
	margin_container.add_child(center)
	
	var title_label = Label.new()
	title_label.set_label_settings(load("res://1_ASSETS/UI/PopupLabelSettings.tres"))
	title_label.set_name("popup_title")
	title_label.set_text(title)
	title_label.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
	center.add_child(title_label)
	
	var top_spacer := center.add_spacer(false)
	top_spacer.set_name("top_spacer")
	
	var scroll = ScrollContainer.new()
	scroll.set_name("message_content")
	scroll.set_horizontal_scroll_mode(ScrollContainer.SCROLL_MODE_DISABLED)
	scroll.custom_minimum_size.y = lines_to_show*32
	center.add_child(scroll)
	
	var label = Label.new()
	label.set_label_settings(load("res://1_ASSETS/UI/PopupLabelSettings.tres"))
	label.set_name("popup_message")
	label.set_text(message)
	scroll.add_child(label)
	
	var buttons = HBoxContainer.new()
	buttons.set_name("buttons")
	center.add_child(buttons)
	
	var l_button_spacer := buttons.add_spacer(false)
	l_button_spacer.set_name("L_button_spacer")
	
	var confirm_button = Button.new()
	confirm_button.set_text("ok!")
	confirm_button.pressed.connect(func(): finished.emit(ReturnCodes.DONE))
	buttons.add_child(confirm_button)
	
	var r_button_spacer := buttons.add_spacer(false)
	r_button_spacer.set_name("R_button_spacer")
	
	var bot_spacer := center.add_spacer(false)
	bot_spacer.set_name("bottom_spacer")

	var r_spacer := add_spacer(false)
	r_spacer.set_name("R_spacer")
	
	set_name("long_dialog_popup")
