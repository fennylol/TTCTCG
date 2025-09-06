extends VBoxContainer
class_name DeckDisplay

signal Save
signal Back
signal ChangeName(name : String)

var Controls := HBoxContainer.new()
var Critters := HBoxContainer.new()
var Consumables := HBoxContainer.new()
var Weapons := HBoxContainer.new()
var Wildcards := HBoxContainer.new()

const PRESSEDICON = preload("res://1_ASSETS/UI/DEBUG_button_pressed.png")
const UNPRESSEDICON = preload("res://1_ASSETS/UI/DEBUG_button.png")

func _init() -> void:
	Controls.name = "Controls"
	Critters.name = "Critters"
	Consumables.name = "Consumables"
	Weapons.name = "Weapons"
	Wildcards.name = "Wildcards"
	
	Controls.add_spacer(true)
	var back_button := Button.new()
	back_button.name="BackButton"
	back_button.text="Back"
	back_button.flat = true
	back_button.icon = UNPRESSEDICON
	back_button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	back_button.pressed.connect(Back.emit)
	back_button.button_down.connect(func(): back_button.icon=PRESSEDICON)
	back_button.button_up.connect(func(): back_button.icon=UNPRESSEDICON)
	Controls.add_child(back_button)
	var save_button := Button.new()
	save_button.name="SaveButton"
	save_button.text="Save"
	save_button.flat = true
	save_button.icon = UNPRESSEDICON
	save_button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	save_button.pressed.connect(Save.emit)
	save_button.button_down.connect(func(): save_button.icon=PRESSEDICON)
	save_button.button_up.connect(func(): save_button.icon=UNPRESSEDICON)
	Controls.add_child(save_button)
	var deck_name := LineEdit.new()
	deck_name.name="DeckName"
	deck_name.text="My Awesome New Deck"
	deck_name.flat = false
	deck_name.max_length = 21
	deck_name.alignment = HORIZONTAL_ALIGNMENT_CENTER
	deck_name.size_flags_horizontal |= Control.SIZE_EXPAND
	deck_name.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	deck_name.size_flags_stretch_ratio = 10.0
	deck_name.text_changed.connect(ChangeName.emit)
	Controls.add_child(deck_name)
	Controls.add_spacer(false)
	
	for i in range(5):
		Critters.add_spacer(false)
		Consumables.add_spacer(false)
		Weapons.add_spacer(false)
		Wildcards.add_spacer(false)
		Critters.get_child(i).name = "spacer"+str(i)
		Consumables.get_child(i).name = "spacer"+str(i)
		Weapons.get_child(i).name = "spacer"+str(i)
		Wildcards.get_child(i).name = "spacer"+str(i)

	Controls.size_flags_vertical |= Control.SIZE_EXPAND
	Critters.size_flags_vertical |= Control.SIZE_EXPAND
	Consumables.size_flags_vertical |= Control.SIZE_EXPAND
	Weapons.size_flags_vertical |= Control.SIZE_EXPAND
	Wildcards.size_flags_vertical |= Control.SIZE_EXPAND
	
	add_child(Controls)
	add_child(Critters)
	add_child(Consumables)
	add_child(Weapons)
	add_child(Wildcards)

func recieve_card(card: Card) -> void:
	var target: HBoxContainer = Wildcards
	var type: DATA.ContentTypes = card.Type
	var _is_spacer = func(node) -> bool: return node.name.begins_with("spacer")
	
	match type:
		DATA.ContentTypes.CRITTER:
			if _is_spacer.call(Critters.get_child(4)):
				target = Critters
		DATA.ContentTypes.CONSUMABLE:
			if _is_spacer.call(Consumables.get_child(4)):
				target = Consumables
		DATA.ContentTypes.WEAPON:
			if _is_spacer.call(Weapons.get_child(4)):
				target = Weapons
	
	if target != Wildcards or _is_spacer.call(Wildcards.get_child(4)):
		target.remove_child(target.get_child(4))
		var texture_rect := TextureRect.new()
		texture_rect.texture = card.Img
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.size_flags_horizontal |= Control.SIZE_EXPAND
		target.add_child(texture_rect)
		target.move_child(texture_rect, 0)
	else:
		print("deck is full")
