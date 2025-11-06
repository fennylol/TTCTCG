extends VBoxContainer
class_name DeckDisplay

signal finished
signal select_deck(deck: Deck)
signal save_deck
signal rename_deck(new_name: String)
signal delete_deck(deck: Deck)
signal select_card(card: Dictionary)

var RealDeckName: String
var DeckName    : LineEdit
var Controls    : HBoxContainer
var Critters    : HBoxContainer
var Consumables : HBoxContainer
var Weapons     : HBoxContainer
var Wildcards   : HBoxContainer
var Editable    := true

const PRESSEDICON = preload("res://1_ASSETS/UI/DEBUG_button_pressed.png")
const UNPRESSEDICON = preload("res://1_ASSETS/UI/DEBUG_button.png")
# ============== #
# call reception #
# ============== #
func _show_decks(deck_list: Dictionary):
	kill_the_child()
	for deck_name in deck_list:
		var dict: Dictionary = deck_list[deck_name]
		var deck := Deck.restore_from_dict(dict)
		
		var deck_button = DeckButton.new(deck, Editable)
		deck_button.selected.connect(func(): select_deck.emit(deck))
		deck_button.deleted.connect(func(): delete_deck.emit(deck))
		add_child(deck_button)
	if Editable: 
		var new_deck := Deck.new()
		var new_deck_button := DeckButton.new(new_deck, false)
		new_deck_button.selected.connect(func(): select_deck.emit(new_deck))
		new_deck_button.deleted.connect(func(): delete_deck.emit(new_deck))
		add_child(new_deck_button)
func _show_deck_content(deck: Deck): 
	prepare_deck_display()
	var read_array = func(arr: Array[Dictionary]): for card in arr: _add_card_to_deck(card)
	DeckName.text = deck.Name
	RealDeckName  = deck.Name
	read_array.call(deck.Critters)
	read_array.call(deck.Consumables)
	read_array.call(deck.Weapons)
	read_array.call(deck.WildCards)
func _add_card_to_deck(card_dict: Dictionary) -> void:
	var card = PlayablePair.restore_from_dict(card_dict) if PlayablePair.dict_is_playable_pair(card_dict) else \
			   Card.restore_from_dict(card_dict) if Card.dict_is_card(card_dict) else null
	assert(card, "deck_display.gd - _add_card_to_deck(): card_dict is not valid")
	
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
		var kill : Control = target.get_child(4)
		target.remove_child(kill)
		kill.queue_free()
		
		var img: Texture2D =  stitch_textures_vertical(card.Img, card.PairedImg) if card is PlayablePair else card.Img 
		var texture_rect := TextureRect.new()
		texture_rect.name = card.Name
		texture_rect.texture = img
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.size_flags_horizontal |= Control.SIZE_EXPAND
		
		var tex_rect_button := Button.new()
		tex_rect_button.set_anchors_and_offsets_preset(PRESET_FULL_RECT)
		tex_rect_button.flat = true
		var dict := card.reduce_to_dict()
		tex_rect_button.pressed.connect(func(): select_card.emit(dict))
		texture_rect.add_child(tex_rect_button)
		target.add_child(texture_rect)
		target.move_child(texture_rect, 0)
	else:
		LOGGER.log_msg("deck_display.gd: deck is full", LOGGER.Flags.WARN_STDOUT)
	card.queue_free()
func _remove_card_from_deck(card_dict: Dictionary):
	assert(PlayablePair.dict_is_playable_pair(card_dict, true), "deck_display.gd - _remove_card_from_deck(): card_dict is not a PlayablePair")
	var card: PlayablePair = PlayablePair.restore_from_dict(card_dict)
	
	var kill
	var container
	for child in Critters.get_children(): 
		if child.name == card.Name: 
			LOGGER.log_msg("deck_display.gd: " + child.name + " is being removed from Critters!")
			kill = child
			container = Critters
			break
	if kill == null:
		for child in Consumables.get_children(): 
			if child.name == card.Name:
				LOGGER.log_msg("deck_display.gd: " + child.name + " is being removed from Consumables!")
				kill = child
				container = Consumables
				break
	if kill == null:
		for child in Weapons.get_children(): 
			if child.name == card.Name:
				LOGGER.log_msg("deck_display.gd: " + child.name + " is being removed from Weapons!")
				kill = child
				container = Weapons
				break
	if kill == null:
		for child in Wildcards.get_children(): 
			if child.name == card.Name: 
				LOGGER.log_msg("deck_display.gd: " + child.name + " is being removed from Wildcards!")
				kill = child
				container = Wildcards
				break
	if kill != null:
		kill.queue_free()
		container.add_spacer(false)
		container.get_child(5).name = "spacer"+str(randi())
	
	card.queue_free()

# ================ #
# internal utility #
# ================ #
func handle_save_deck() -> void:
	if RealDeckName != DeckName.text:
		RealDeckName = DeckName.text
		rename_deck.emit(DeckName.text)
	else: save_deck.emit()
func stitch_textures_vertical(top_texture: Texture2D, bottom_texture: Texture2D) -> ImageTexture:
	var top_image = top_texture.get_image()
	var bottom_image = bottom_texture.get_image()
	assert(top_image.get_format() == bottom_image.get_format(), "formats dont match.\ntop format: " + str(top_image.get_format()) + "\ntbottom format: " + str(bottom_image.get_format()))
	
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
	
	if DeckName:    DeckName.queue_free()
	if Controls:    Controls.queue_free()
	if Critters:    Critters.queue_free()
	if Consumables: Consumables.queue_free()
	if Weapons:     Weapons.queue_free()
	if Wildcards:   Wildcards.queue_free()
	
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
	if Editable:
		var save_button := Button.new()
		save_button.name="SaveButton"
		save_button.text="Save"
		save_button.flat = true
		save_button.icon = UNPRESSEDICON
		save_button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
		save_button.pressed.connect(handle_save_deck)
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
	DeckName.editable = Editable
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
