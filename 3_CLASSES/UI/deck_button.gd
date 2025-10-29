extends HBoxContainer
class_name DeckButton

signal selected
signal deleted

const MINUS_ICON = preload("res://1_ASSETS/UI/-.png")
const PLUS_ICON =  preload("res://1_ASSETS/UI/+.png")
const X_ICON =     preload("res://1_ASSETS/UI/X.png")

func _init(deck: Deck, AddDeleteButton: bool = true) -> void:
	name = deck.Name.replace(" ", "_").to_lower() + "_list"
	size_flags_vertical |= Control.SIZE_EXPAND
	
	var first_card := PlayablePair.restore_from_dict(deck.Critters[0])    if deck.Critters.size()    > 0 else \
					  PlayablePair.restore_from_dict(deck.Consumables[0]) if deck.Consumables.size() > 0 else \
					  PlayablePair.restore_from_dict(deck.Weapons[0])     if deck.Weapons.size()     > 0 else null
	var icon := first_card.Img if first_card else PLUS_ICON if deck.Name == "New Deck" else MINUS_ICON 
	if first_card is PlayablePair: first_card.queue_free()
	
	#var imgs: Array[Texture2D] = []
	#for i in range(0,5):
		#print(i)
		#if deck.Critters.size() > i:
			#var c: Card = PlayablePair.restore_from_dict(deck.Critters[i]) 
			#imgs.append(c.Img)
			#c.queue_free()
		#if deck.Consumables.size() > i:
			#var c: Card = PlayablePair.restore_from_dict(deck.Consumables[i]) 
			#imgs.append(c.Img)
			#c.queue_free()
		#if deck.Weapons.size() > i:
			#var c: Card = PlayablePair.restore_from_dict(deck.Weapons[i]) 
			#imgs.append(c.Img)
			#c.queue_free()
	#var icon = stitch_textures_horizontal(imgs) if imgs != [] else PLUS_ICON if deck.Name == "New Deck" else MINUS_ICON 
	
	var plain_name: String = deck.Name.replace(" ", "_").to_lower()
	
	var deck_button := Button.new()
	deck_button.flat = true
	deck_button.name = "edit_" + plain_name + "_button"
	deck_button.size_flags_horizontal |= Control.SIZE_EXPAND
	deck_button.pressed.connect(selected.emit)
	add_child(deck_button)
	
	var deck_sprite := TextureRect.new()
	deck_sprite.name = plain_name + "_icon"
	deck_sprite.texture = icon
	deck_sprite.set_expand_mode(TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL)
	deck_sprite.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT_COVERED)
	deck_sprite.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	deck_button.add_child(deck_sprite)
	
	var deck_label := Label.new()
	deck_label.name = plain_name + "_label"
	deck_label.text = deck.Name
	deck_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	deck_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	deck_label.set_anchors_preset(Control.PRESET_FULL_RECT)
	deck_button.add_child(deck_label)
	
	var deck_label_settings := LabelSettings.new()
	deck_label_settings.font_size = 32
	deck_label.set_label_settings(deck_label_settings)
	
	if AddDeleteButton:
		var delete_button := TextureButton.new()
		delete_button.name = "delete_" + plain_name + "_button"
		delete_button.texture_normal = X_ICON
		delete_button.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		delete_button.pressed.connect(deleted.emit)
		add_child(delete_button)

static func stitch_textures_horizontal(textures: Array[Texture2D], max_imgs: int = -1) -> ImageTexture:
	if textures.is_empty():
		return null
	
	# Determine how many images to process
	var num_to_process = textures.size()
	if max_imgs > 0:
		num_to_process = min(max_imgs, textures.size())
	
	# Get all images and find dimensions
	var images: Array[Image] = []
	var total_width = 0
	var max_height = 0
	
	for i in range(num_to_process):
		var img = textures[i].get_image()
		images.append(img)
		var img_size = img.get_size()
		total_width += img_size.x
		max_height = max(max_height, img_size.y)
	
	# Create combined image with format from first texture
	var combined_image = Image.create(total_width, max_height, false, images[0].get_format())
	combined_image.fill(Color(0, 0, 0, 1))
	
	# Blit each image horizontally
	var current_x = 0
	for img in images:
		var img_size = img.get_size()
		combined_image.blit_rect(img, Rect2i(Vector2i.ZERO, img_size), Vector2i(current_x, 0))
		current_x += img_size.x
	
	var result_texture = ImageTexture.new()
	result_texture.set_image(combined_image)
	
	return result_texture
