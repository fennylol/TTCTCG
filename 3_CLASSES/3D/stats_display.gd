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
#
#match Type:
		#DATA.ContentTypes.CRITTER:
			#assert(StatsDict.keys().has(DATA.CritterDescriptionFields.FLAVOR),   "card.gd - get_stats_string(): CritterDescriptionFields.FLAVOR does not exist")
			#assert(StatsDict.keys().has(DATA.CritterDescriptionFields.HEALTH),   "card.gd - get_stats_string(): CritterDescriptionFields.HEALTH does not exist")
			#assert(StatsDict.keys().has(DATA.CritterDescriptionFields.SPEED),    "card.gd - get_stats_string(): CritterDescriptionFields.SPEED does not exist")
			#assert(StatsDict.keys().has(DATA.CritterDescriptionFields.DAMAGE),   "card.gd - get_stats_string(): CritterDescriptionFields.DAMAGE does not exist")
			#assert(StatsDict.keys().has(DATA.CritterDescriptionFields.EYESIGHT), "card.gd - get_stats_string(): CritterDescriptionFields.EYESIGHT does not exist")
			#assert(StatsDict.keys().has(DATA.CritterDescriptionFields.HEARING),  "card.gd - get_stats_string(): CritterDescriptionFields.HEARING does not exist")
			#assert(StatsDict.keys().has(DATA.CritterDescriptionFields.NATURE),   "card.gd - get_stats_string(): CritterDescriptionFields.NATURE does not exist")
			#var min_len: int = 8 # the legnth of DATA.CritterDescriptionFields.NATURE.SKITTISH
			#if StringA: 
				#return  "HP:  "+str(StatsDict[DATA.CritterDescriptionFields.HEALTH]).rpad(min_len)+"\n"+\
						#"SPD: "+str(StatsDict[DATA.CritterDescriptionFields.SPEED]).rpad(min_len) +"\n"+\
						#"DMG: "+str(StatsDict[DATA.CritterDescriptionFields.DAMAGE]).rpad(min_len)
			#else:
				#return  "EYE:  "+str(                             StatsDict[DATA.CritterDescriptionFields.EYESIGHT]).lpad(min_len)+"\n"+\
						#"HEAR: "+str(                             StatsDict[DATA.CritterDescriptionFields.HEARING]).lpad(min_len) +"\n"+\
						#"NAT:  "+str(DATA.CritterNatures.find_key(StatsDict[DATA.CritterDescriptionFields.NATURE])).lpad(min_len)
		#DATA.ContentTypes.CONSUMABLE:
			#assert(StatsDict.keys().has(DATA.ConsumableDescriptionFields.FLAVOR), "card.gd - get_stats_string(): ConsumableDescriptionFields.FLAVOR does not exist.")
			#assert(StatsDict.keys().has(DATA.ConsumableDescriptionFields.RANGE),  "card.gd - get_stats_string(): ConsumableDescriptionFields.RANGE does not exist.")
			#assert(StatsDict.keys().has(DATA.ConsumableDescriptionFields.DAMAGE), "card.gd - get_stats_string(): ConsumableDescriptionFields.DAMAGE does not exist.")
			#assert(StatsDict.keys().has(DATA.ConsumableDescriptionFields.AOE),    "card.gd - get_stats_string(): ConsumableDescriptionFields.AOE does not exist.")
			#assert(StatsDict.keys().has(DATA.ConsumableDescriptionFields.TARGET), "card.gd - get_stats_string(): ConsumableDescriptionFields.TARGET does not exist.")
			#var min_len: int = 7 # the legnth of DATA.Targets.TERRAIN
			#if StringA: 
				#return  "RNG: "+str(StatsDict[DATA.ConsumableDescriptionFields.RANGE]).rpad(min_len)+"\n"+\
						#"DMG: "+str(StatsDict[DATA.ConsumableDescriptionFields.DAMAGE]).rpad(min_len)
			#else:
				#return  "AOE: "+str(                      StatsDict[DATA.ConsumableDescriptionFields.AOE]).lpad(min_len)+"\n"+\
						#"TGT: "+str(DATA.Targets.find_key(StatsDict[DATA.ConsumableDescriptionFields.TARGET])).lpad(min_len)
				#
		#DATA.ContentTypes.WEAPON:
			#assert(StatsDict.keys().has(DATA.WeaponDescriptionFields.FLAVOR),   "card.gd - get_stats_string(): WeaponDescriptionFields.FLAVOR does not exist")
			#assert(StatsDict.keys().has(DATA.WeaponDescriptionFields.RANGE),    "card.gd - get_stats_string(): WeaponDescriptionFields.RANGE does not exist")
			#assert(StatsDict.keys().has(DATA.WeaponDescriptionFields.DAMAGE),   "card.gd - get_stats_string(): WeaponDescriptionFields.DAMAGE does not exist")
			#assert(StatsDict.keys().has(DATA.WeaponDescriptionFields.AMMO),     "card.gd - get_stats_string(): WeaponDescriptionFields.AMMO does not exist")
			#assert(StatsDict.keys().has(DATA.WeaponDescriptionFields.ACCURACY), "card.gd - get_stats_string(): WeaponDescriptionFields.ACCURACY does not exist")
			#assert(StatsDict.keys().has(DATA.WeaponDescriptionFields.FIRERATE), "card.gd - get_stats_string(): WeaponDescriptionFields.FIRERATE does not exist")
			#assert(StatsDict.keys().has(DATA.WeaponDescriptionFields.TARGET),   "card.gd - get_stats_string(): WeaponDescriptionFields.TARGET does not exist")
			#var min_len: int = 7 # the legnth of DATA.Targets.TERRAIN
			#if StringA: 
				#return  "RNG: "+str(StatsDict[DATA.WeaponDescriptionFields.RANGE]).rpad(min_len)+"\n"+\
						#"DMG: "+str(StatsDict[DATA.WeaponDescriptionFields.DAMAGE]).rpad(min_len) +"\n"+\
						#"AMO: "+str(StatsDict[DATA.WeaponDescriptionFields.AMMO]).rpad(min_len)
			#else:
				#return  "ACC: "+str(                      StatsDict[DATA.WeaponDescriptionFields.ACCURACY]).lpad(min_len)+"\n"+\
						#"RPM: "+str(                      StatsDict[DATA.WeaponDescriptionFields.FIRERATE]).lpad(min_len) +"\n"+\
						#"TGT: "+str(DATA.Targets.find_key(StatsDict[DATA.WeaponDescriptionFields.TARGET])).lpad(min_len)
