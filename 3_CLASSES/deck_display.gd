extends VBoxContainer
class_name DeckDisplay2

signal finished
signal select_deck(deck: Deck)
signal save_deck
signal rename_deck(new_name: String)
signal delete_deck
signal remove_card_from_deck(card: PlayablePair)

var DeckName := LineEdit.new()
var Controls := HBoxContainer.new()
var Critters := HBoxContainer.new()
var Consumables := HBoxContainer.new()
var Weapons := HBoxContainer.new()
var Wildcards := HBoxContainer.new()

const PRESSEDICON = preload("res://1_ASSETS/UI/DEBUG_button_pressed.png")
const UNPRESSEDICON = preload("res://1_ASSETS/UI/DEBUG_button.png")
const X_ICON = preload("res://1_ASSETS/UI/X.png")
const PLUS_ICON = preload("res://1_ASSETS/UI/+.png")
# ============== #
# call reception #
# ============== #
func _show_decks(deck_list: Dictionary):
	kill_the_child()
	for deck_name in deck_list:
		var dict: Dictionary = deck_list[deck_name]
		var deck := Deck.parse_single_deck(dict)
		var icon := deck.Critters[0].Img if deck.Critters.size() > 0 else \
					deck.Consumables[0].Img if deck.Consumables.size() > 0 else \
					deck.Weapons[0].Img if deck.Weapons.size() > 0 else X_ICON
		deck.Name = deck_name
		var deck_button = new_deck_button(deck, icon)
		add_child(deck_button)
	add_child(new_deck_button(Deck.new(), PLUS_ICON, false))
func _show_deck_content(deck: Deck): 
	prepare_deck_display()
	var read_array = func(arr: Array[PlayablePair]): for card in arr: _add_card_to_deck(card)
	DeckName.text = deck.Name
	read_array.call(deck.Critters)
	read_array.call(deck.Consumables)
	read_array.call(deck.Weapons)
	read_array.call(deck.WildCards)
func _add_card_to_deck(card: Card) -> void:
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
		var img: Texture2D = card.Img 
		if card is PlayablePair:
			img = stitch_textures_vertical(card.Img, card.PairedImg)
		
		target.remove_child(target.get_child(4))
		var texture_rect := TextureRect.new()
		texture_rect.texture = img
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.size_flags_horizontal |= Control.SIZE_EXPAND
		
		var tex_rect_button := Button.new()
		tex_rect_button.set_anchors_and_offsets_preset(PRESET_FULL_RECT)
		tex_rect_button.flat = true
		tex_rect_button.pressed.connect(func(): 
											texture_rect.queue_free()
											target.add_spacer(false)
											target.get_child(5).name = "spacer"+str(randi())
											remove_card_from_deck.emit(card))
		texture_rect.add_child(tex_rect_button)
		target.add_child(texture_rect)
		target.move_child(texture_rect, 0)
	else:
		LOGGER.log_msg("deck is full", LOGGER.Flags.WARN_STDOUT)

# ================ #
# internal utility #
# ================ #
func new_deck_button(deck: Deck, icon: Texture2D, AddDeleteButton: bool = true) -> HBoxContainer:
	var cntl := HBoxContainer.new()
	cntl.name = deck.Name.replace(" ", "_").to_lower() + "_list"
	
	var deck_button := TextureButton.new()
	deck_button.name = "edit_" + deck.Name.replace(" ", "_").to_lower() + "_button"
	deck_button.texture_normal = icon
	deck_button.size_flags_horizontal |= Control.SIZE_EXPAND
	deck_button.pressed.connect(func(): select_deck.emit(deck))
	cntl.add_child(deck_button)
	
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
		delete_button.pressed.connect(func(): delete_deck.emit(deck))
		cntl.add_child(delete_button)
	
	return cntl
func stitch_textures_vertical(top_texture: Texture2D, bottom_texture: Texture2D) -> ImageTexture:
	var top_image = top_texture.get_image()
	var bottom_image = bottom_texture.get_image()
	assert(top_image.get_format() == bottom_image.get_format())
	
	var top_size = top_image.get_size()
	var bottom_size = bottom_image.get_size()
	var final_width = max(top_size.x, bottom_size.x)
	var final_height = top_size.y + bottom_size.y
	var combined_image = Image.create(final_width, final_height, false, top_image.get_format())

	combined_image.fill(Color(0, 0, 0, 1))
	combined_image.blit_rect(top_image, Rect2i(Vector2i.ZERO, top_size), Vector2i.ZERO)
	combined_image.blit_rect(bottom_image, Rect2i(Vector2i.ZERO, bottom_size), Vector2i(0, top_size.y))

	var result_texture = ImageTexture.new()
	result_texture.set_image(combined_image)
	
	return result_texture
func kill_the_child() -> void: 
	for i in range(get_child_count()): 
		get_child(i).queue_free()
func prepare_deck_display():
	kill_the_child()
	
	DeckName = LineEdit.new()
	Controls = HBoxContainer.new()
	Critters = HBoxContainer.new()
	Consumables = HBoxContainer.new()
	Weapons = HBoxContainer.new()
	Wildcards = HBoxContainer.new()
	
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
	back_button.pressed.connect(finished.emit)
	back_button.button_down.connect(func(): back_button.icon=PRESSEDICON)
	back_button.button_up.connect(func(): back_button.icon=UNPRESSEDICON)
	Controls.add_child(back_button)
	var save_button := Button.new()
	save_button.name="SaveButton"
	save_button.text="Save"
	save_button.flat = true
	save_button.icon = UNPRESSEDICON
	save_button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	save_button.pressed.connect(save_deck.emit)
	save_button.button_down.connect(func(): save_button.icon=PRESSEDICON)
	save_button.button_up.connect(func(): save_button.icon=UNPRESSEDICON)
	Controls.add_child(save_button)
	DeckName.name="DeckName"
	DeckName.text="My Awesome New Deck"
	DeckName.flat = false
	DeckName.max_length = 21
	DeckName.alignment = HORIZONTAL_ALIGNMENT_CENTER
	DeckName.size_flags_horizontal |= Control.SIZE_EXPAND
	DeckName.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	DeckName.size_flags_stretch_ratio = 10.0
	DeckName.text_changed.connect(rename_deck.emit)
	Controls.add_child(DeckName)
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
