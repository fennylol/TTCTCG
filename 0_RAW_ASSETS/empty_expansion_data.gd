#const SAMPLE_CRITTERS: Array[Dictionary] = [
	#{
		#DATA.ExpansionContentFields.NAME : "oops", 
		#DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		#DATA.ExpansionContentFields.STATS : {
			#DATA.CritterDescriptionFields.FLAVOR   : "a critter named oops",
			#DATA.CritterDescriptionFields.HEALTH   : 100,
			#DATA.CritterDescriptionFields.SPEED    : 100,
			#DATA.CritterDescriptionFields.DAMAGE   : 100,
			#DATA.CritterDescriptionFields.EYESIGHT : 100,
			#DATA.CritterDescriptionFields.HEARING  : 100,
			#DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		#}
	#}
#]
#
#const SAMPLE_CONSUMABLES: Array[Dictionary] = [
	#{
		#DATA.ExpansionContentFields.NAME : "oops", 
		#DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		#DATA.ExpansionContentFields.STATS : {
			#DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named oops",
			#DATA.ConsumableDescriptionFields.RANGE  : 100,
			#DATA.ConsumableDescriptionFields.DAMAGE : 100,
			#DATA.ConsumableDescriptionFields.AOE    : 1,
			#DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		#}
	#}
#]
#
#const SAMPLE_WEAPONS: Array[Dictionary] = [
	#{
		#DATA.ExpansionContentFields.NAME : "oops", 
		#DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		#DATA.ExpansionContentFields.STATS : {
			#DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named oops",
			#DATA.WeaponDescriptionFields.RANGE    : 100,
			#DATA.WeaponDescriptionFields.DAMAGE   : 100,
			#DATA.WeaponDescriptionFields.AMMO     : 10,
			#DATA.WeaponDescriptionFields.ACCURACY : 100,
			#DATA.WeaponDescriptionFields.FIRERATE : 100,
			#DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		#}
	#}
#]        


const EXPANSION_DATA: Dictionary = {
	DATA.ProbabilityCurveFields.PACK_RARITY_ODDS : [0.564, 0.248, 0.109, 0.048, 0.021, 0.010], # exponential, B=0.44
	DATA.ProbabilityCurveFields.CONTENT_RARITY_ODDS : [
		[0.357, 0.341, 0.202, 0.080, 0.018, 0.002], # beta, A=2.05, S=4.25
		[0.287, 0.344, 0.235, 0.105, 0.026, 0.003], # beta, A=2.35, S=4.15
		[0.224, 0.336, 0.266, 0.133, 0.037, 0.004], # beta, A=2.65, S=4.05
		[0.170, 0.319, 0.291, 0.164, 0.051, 0.005], # beta, A=2.95, S=3.95
		[0.125, 0.294, 0.310, 0.196, 0.068, 0.007], # beta, A=3.25, S=3.85
		[0.090, 0.264, 0.321, 0.227, 0.088, 0.010]  # beta, A=3.55, S=3.75
	],
	DATA.ProbabilityCurveFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
}

func COMMON_CRITTER() -> void: pass
const COMMON_CRITTERS: Array[Dictionary] = [
	
]



func COMMON_CONSUMABLE() -> void: pass
const COMMON_CONSUMABLES: Array[Dictionary] = [
	
]



func COMMON_WEAPON() -> void: pass
const COMMON_WEAPONS: Array[Dictionary] = [
	
]




 
func UNCOMMON_CRITTER() -> void: pass
const UNCOMMON_CRITTERS: Array[Dictionary] = [
	
]



func UNCOMMON_CONSUMABLE() -> void: pass
const UNCOMMON_CONSUMABLES: Array[Dictionary] = [
	
]



func UNCOMMON_WEAPON() -> void: pass
const UNCOMMON_WEAPONS: Array[Dictionary] = [
	
]




 
func RARE_CRITTER() -> void: pass
const RARE_CRITTERS: Array[Dictionary] = [
	
]



func RARE_CONSUMABLE() -> void: pass
const RARE_CONSUMABLES: Array[Dictionary] = [
	
]



func RARE_WEAPON() -> void: pass
const RARE_WEAPONS: Array[Dictionary] = [
	
]




 
func EPIC_CRITTER() -> void: pass
const EPIC_CRITTERS: Array[Dictionary] = [
	
]



func EPIC_CONSUMABLE() -> void: pass
const EPIC_CONSUMABLES: Array[Dictionary] = [
	
]



func EPIC_WEAPON() -> void: pass
const EPIC_WEAPONS: Array[Dictionary] = [
	
]




 
func LEGENDARY_CRITTER() -> void: pass
const LEGENDARY_CRITTERS: Array[Dictionary] = [
	
]



func LEGENDARY_CONSUMABLE() -> void: pass
const LEGENDARY_CONSUMABLES: Array[Dictionary] = [
	
]



func LEGENDARY_WEAPON() -> void: pass
const LEGENDARY_WEAPONS: Array[Dictionary] = [
	
]




 
func HOLY_MOLY_CRITTER() -> void: pass
const HOLY_MOLY_CRITTERS: Array[Dictionary] = [
	
]



func HOLY_MOLY_CONSUMABLE() -> void: pass
const HOLY_MOLY_CONSUMABLES: Array[Dictionary] = [
	
]



func HOLY_MOLY_WEAPON() -> void: pass
const HOLY_MOLY_WEAPONS: Array[Dictionary] = [
	
]


const EXPANSION_CONTENT: Dictionary = {
	DATA.Rarities.COMMON : {
		DATA.ContentTypes.CRITTER    : COMMON_CRITTERS,
		DATA.ContentTypes.CONSUMABLE : COMMON_CONSUMABLES,
		DATA.ContentTypes.WEAPON     : COMMON_WEAPONS
	},
	DATA.Rarities.UNCOMMON : {
		DATA.ContentTypes.CRITTER    : UNCOMMON_CRITTERS,
		DATA.ContentTypes.CONSUMABLE : UNCOMMON_CONSUMABLES,
		DATA.ContentTypes.WEAPON     : UNCOMMON_WEAPONS
	},
	DATA.Rarities.RARE : {
		DATA.ContentTypes.CRITTER    : RARE_CRITTERS,
		DATA.ContentTypes.CONSUMABLE : RARE_CONSUMABLES,
		DATA.ContentTypes.WEAPON     : RARE_WEAPONS
	},
	DATA.Rarities.EPIC : {
		DATA.ContentTypes.CRITTER    : EPIC_CRITTERS,
		DATA.ContentTypes.CONSUMABLE : EPIC_CONSUMABLES,
		DATA.ContentTypes.WEAPON     : EPIC_WEAPONS
	},
	DATA.Rarities.LEGENDARY : {
		DATA.ContentTypes.CRITTER    : LEGENDARY_CRITTERS,
		DATA.ContentTypes.CONSUMABLE : LEGENDARY_CONSUMABLES,
		DATA.ContentTypes.WEAPON     : LEGENDARY_WEAPONS
	},
	DATA.Rarities.HOLY_MOLY : {
		DATA.ContentTypes.CRITTER    : HOLY_MOLY_CRITTERS,
		DATA.ContentTypes.CONSUMABLE : HOLY_MOLY_CONSUMABLES,
		DATA.ContentTypes.WEAPON     : HOLY_MOLY_WEAPONS
	}
}
