extends Node3D
class_name StatsDisplay

const CRITTER_ICONS: Dictionary = {
	DATA.CritterDescriptionFields.HEALTH   : preload("res://1_ASSETS/cards/art/icon/health_icon.png"),
	DATA.CritterDescriptionFields.DAMAGE   : preload("res://1_ASSETS/cards/art/icon/damage_icon.png"),
	DATA.CritterDescriptionFields.SPEED    : preload("res://1_ASSETS/cards/art/icon/speed_icon.png"),
	DATA.CritterDescriptionFields.EYESIGHT : preload("res://1_ASSETS/cards/art/icon/eyesight_icon.png"),
	DATA.CritterDescriptionFields.HEARING  : preload("res://1_ASSETS/cards/art/icon/hearing_icon.png"),
	DATA.CritterDescriptionFields.NATURE   : preload("res://1_ASSETS/cards/art/icon/nature_icon.png")
}
const CONSUMABLE_ICONS: Dictionary = {
	DATA.ConsumableDescriptionFields.RANGE  : preload("res://1_ASSETS/cards/art/icon/speed_icon.png"),
	DATA.ConsumableDescriptionFields.DAMAGE : preload("res://1_ASSETS/cards/art/icon/damage_icon.png"),
	DATA.ConsumableDescriptionFields.AOE    : preload("res://1_ASSETS/cards/art/icon/eyesight_icon.png"),
	DATA.ConsumableDescriptionFields.TARGET : preload("res://1_ASSETS/cards/art/icon/hearing_icon.png")
}
const WEAPON_ICONS: Dictionary = {
	DATA.WeaponDescriptionFields.RANGE    : preload("res://1_ASSETS/cards/art/icon/health_icon.png"),
	DATA.WeaponDescriptionFields.DAMAGE   : preload("res://1_ASSETS/cards/art/icon/speed_icon.png"),
	DATA.WeaponDescriptionFields.AMMO     : preload("res://1_ASSETS/cards/art/icon/damage_icon.png"),
	DATA.WeaponDescriptionFields.ACCURACY : preload("res://1_ASSETS/cards/art/icon/eyesight_icon.png"),
	DATA.WeaponDescriptionFields.FIRERATE : preload("res://1_ASSETS/cards/art/icon/hearing_icon.png"),
	DATA.WeaponDescriptionFields.TARGET   : preload("res://1_ASSETS/cards/art/icon/nature_icon.png")
}

func _init(type: DATA.ContentTypes, stats: Dictionary, pixel_size: float = 0.00325) -> void:
	var icons: Dictionary
	var label_names: Dictionary
	#var icons: Dictionary = CRITTER_ICONS    if type == DATA.ContentTypes.CRITTER    else \
							#CONSUMABLE_ICONS if type == DATA.ContentTypes.CONSUMABLE else \
							#CONSUMABLE_ICONS if type == DATA.ContentTypes.WEAPON     else {}
	
	match type:
		DATA.ContentTypes.CRITTER:
			icons = CRITTER_ICONS
			label_names = DATA.CritterDescriptionFields
		DATA.ContentTypes.CONSUMABLE:
			icons = CONSUMABLE_ICONS
			label_names = DATA.ConsumableDescriptionFields
		DATA.ContentTypes.WEAPON:
			icons = WEAPON_ICONS
			label_names = DATA.WeaponDescriptionFields
	
	
	#var texture_seed = int(RNG.random_value()*0xBEEF)
	var dist = Card.CARD_WIDTH/(icons.size()+1)
	for key in icons:
		var plain_name = label_names.find_key(key)
		
		var sprite = Sprite3D.new()
		sprite.set_name(plain_name+"_sprite")
		sprite.set_texture(icons[key])
		sprite.set_pixel_size(pixel_size)
		sprite.set_render_priority(1)
		sprite.position.x = (get_child_count()-(icons.size()-1)/2.0)*dist
		#var sprite_mat = DATA.create_sprite_shader_material(sprite.texture, texture_seed)
		#sprite.set_material_override(sprite_mat)
		
		var label = Label3D.new()
		label.set_name(plain_name+"_label")
		label.set_text(str(stats[key]))
		label.set_render_priority(3)
		label.set_outline_render_priority(2)
		label.position.z = 0.001
		sprite.add_child(label)
		
		add_child(sprite)
	_change_material(false)
func _change_material(shaded: bool) -> void:
	if shaded:
		var texture_seed = int(RNG.random_value()*0xBEEF)
		for sprite in get_children():
			var sprite_mat = DATA.create_sprite_shader_material(sprite.texture, texture_seed)
			sprite.set_material_override(sprite_mat)
	else:
		for sprite in get_children():
			sprite.set_material_override(null)

func _disable():
	for sprite in get_children():
		var img = sprite.texture.get_image()
		img.convert(Image.Format.FORMAT_LA8)
		sprite.set_texture(ImageTexture.create_from_image(img))
		#sprite.get_child(0).queue_free()
