extends VBoxContainer
class_name DeckDisplay

signal Back
signal Save
signal ChangeName(new_name : String)
signal RemoveCard(card : PlayablePair)

var DeckName := LineEdit.new()
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
	DeckName.name="DeckName"
	DeckName.text="My Awesome New Deck"
	DeckName.flat = false
	DeckName.max_length = 21
	DeckName.alignment = HORIZONTAL_ALIGNMENT_CENTER
	DeckName.size_flags_horizontal |= Control.SIZE_EXPAND
	DeckName.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	DeckName.size_flags_stretch_ratio = 10.0
	DeckName.text_changed.connect(ChangeName.emit)
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

func recieve_deck(deck: Deck) -> void:
	var read_array = func(arr: Array[PlayablePair]):
		for card in arr:
			recieve_card(card)
	
	DeckName.text = deck.Name
	read_array.call(deck.Critters)
	read_array.call(deck.Consumables)
	read_array.call(deck.Weapons)
	read_array.call(deck.WildCards)

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
											RemoveCard.emit(card))
		texture_rect.add_child(tex_rect_button)
		target.add_child(texture_rect)
		target.move_child(texture_rect, 0)
	else:
		print("deck is full")

func stitch_textures_vertical(top_texture: Texture2D, bottom_texture: Texture2D) -> ImageTexture:
	var top_image = top_texture.get_image()
	var bottom_image = bottom_texture.get_image()
	assert(top_image.get_format() == bottom_image.get_format())
	
	var top_size = top_image.get_size()
	var bottom_size = bottom_image.get_size()
	var final_width = max(top_size.x, bottom_size.x)
	var final_height = top_size.y + bottom_size.y
	var combined_image = Image.create(final_width, final_height, false, top_image.get_format())

	combined_image.fill(Color(0, 0, 0, 0))
	combined_image.blit_rect(top_image, Rect2i(Vector2i.ZERO, top_size), Vector2i.ZERO)
	combined_image.blit_rect(bottom_image, Rect2i(Vector2i.ZERO, bottom_size), Vector2i(0, top_size.y))

	var result_texture = ImageTexture.new()
	result_texture.set_image(combined_image)
	
	return result_texture
