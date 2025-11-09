class_name IncheftionData

# Rarities                   
# ExpansionDataFields        
# ExpansionContentFields     
# CritterDescriptionFields   
# CritterNatures             
# ConsumableDescriptionFields
# WeaponDescriptionFields    
# Targets                    
# ContentTypes               

const EXPANSION_DATA: Dictionary = {
	DATA.ExpansionDataFields.PACK_RARITY_ODDS : [0.564, 0.248, 0.109, 0.048, 0.021, 0.010], # exponential, B=0.44
	DATA.ExpansionDataFields.CONTENT_RARITY_ODDS : [
		[0.357, 0.341, 0.202, 0.080, 0.018, 0.002], # beta, A=2.05, S=4.25
		[0.287, 0.344, 0.235, 0.105, 0.026, 0.003], # beta, A=2.35, S=4.15
		[0.224, 0.336, 0.266, 0.133, 0.037, 0.004], # beta, A=2.65, S=4.05
		[0.170, 0.319, 0.291, 0.164, 0.051, 0.005], # beta, A=2.95, S=3.95
		[0.125, 0.294, 0.310, 0.196, 0.068, 0.007], # beta, A=3.25, S=3.85
		[0.090, 0.264, 0.321, 0.227, 0.088, 0.010]  # beta, A=3.55, S=3.75
	],
	DATA.ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
}

func COMMON_CRITTER() -> void: pass
const COMMON_CRITTERS: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME  : "Bort", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/bort_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Bort",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE   : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME  : "Droopler", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/drooper_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Droopler",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME  : "Geppa", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/geppa_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Geppa",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME  : "Glormpus The Great Frog", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/glormpus_the_great_frog_HD.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "This big hungry frog wants his cake so FUCKING bad. He'll take a beating just to get some. (And he can fit a TON of cake in that big, fat, belly of his.)",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME  : "Smudge", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/smudge_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Smudge",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME  : "Snooflemander", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/snooflemander_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Snooflemander",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME  : "Tamray", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/tamray_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Tamray",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	}
]



func COMMON_CONSUMABLE() -> void: pass
const COMMON_CONSUMABLES: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named oops",
			DATA.ConsumableDescriptionFields.RANGE  : 100,
			DATA.ConsumableDescriptionFields.DAMAGE : 100,
			DATA.ConsumableDescriptionFields.AOE    : 1,
			DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		}
	}
]



func COMMON_WEAPON() -> void: pass
const COMMON_WEAPONS: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named oops",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	}
]




 
func UNCOMMON_CRITTER() -> void: pass
const UNCOMMON_CRITTERS: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "Gepper", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/gepper_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Gepper",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Gubbi", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/gubbi_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Gubbi",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Horrorse", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/horrorse_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Horrorse",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Jooble", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/jooble_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Jooble",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Meeber", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/meeber_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Meeber",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Slorbor", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/slorbor_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Slorbor",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Weird Fish", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/weird_fish_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Weird",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	}
]



func UNCOMMON_CONSUMABLE() -> void: pass
const UNCOMMON_CONSUMABLES: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named oops",
			DATA.ConsumableDescriptionFields.RANGE  : 100,
			DATA.ConsumableDescriptionFields.DAMAGE : 100,
			DATA.ConsumableDescriptionFields.AOE    : 1,
			DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "oops2", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named oops2",
			DATA.ConsumableDescriptionFields.RANGE  : 100,
			DATA.ConsumableDescriptionFields.DAMAGE : 100,
			DATA.ConsumableDescriptionFields.AOE    : 1,
			DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		}
	}
]



func UNCOMMON_WEAPON() -> void: pass
const UNCOMMON_WEAPONS: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named oops",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "oops2", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named oops2",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	}
]




 
func RARE_CRITTER() -> void: pass
const RARE_CRITTERS: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "Audisea", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/2_Rare/audisea_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Audisea",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Cathagaire", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/2_Rare/cathagaire_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Cathagaire",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Geppington", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/2_Rare/gepington_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Geppington",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Gooberta", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/2_Rare/gooberta_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Gooberta",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Smearzorg", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/2_Rare/smearzorg_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Smearzorg",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Zerlemoth", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/2_Rare/zerlemoth_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Zerlemoth",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Weirder Fish", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/weird_fish_sketch.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Weirder",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	}
]



func RARE_CONSUMABLE() -> void: pass
const RARE_CONSUMABLES: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named oops",
			DATA.ConsumableDescriptionFields.RANGE  : 100,
			DATA.ConsumableDescriptionFields.DAMAGE : 100,
			DATA.ConsumableDescriptionFields.AOE    : 1,
			DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		}
	}
]




func RARE_WEAPON() -> void: pass
const RARE_WEAPONS: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named oops",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	}
]




 
func EPIC_CRITTER() -> void: pass
const EPIC_CRITTERS: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named oops (epic)",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	}
]



func EPIC_CONSUMABLE() -> void: pass
const EPIC_CONSUMABLES: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named oops",
			DATA.ConsumableDescriptionFields.RANGE  : 100,
			DATA.ConsumableDescriptionFields.DAMAGE : 100,
			DATA.ConsumableDescriptionFields.AOE    : 1,
			DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		}
	}
]



func EPIC_WEAPON() -> void: pass
const EPIC_WEAPONS: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named oops",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	}
]




 
func LEGENDARY_CRITTER() -> void: pass
const LEGENDARY_CRITTERS: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named oops",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	}
]



func LEGENDARY_CONSUMABLE() -> void: pass
const LEGENDARY_CONSUMABLES: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named oops",
			DATA.ConsumableDescriptionFields.RANGE  : 100,
			DATA.ConsumableDescriptionFields.DAMAGE : 100,
			DATA.ConsumableDescriptionFields.AOE    : 1,
			DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		}
	}
]



func LEGENDARY_WEAPON() -> void: pass
const LEGENDARY_WEAPONS: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named oops",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	}
]




 
func HOLY_MOLY_CRITTER() -> void: pass
const HOLY_MOLY_CRITTERS: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named oops",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	}
]



func HOLY_MOLY_CONSUMABLE() -> void: pass
const HOLY_MOLY_CONSUMABLES: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named oops",
			DATA.ConsumableDescriptionFields.RANGE  : 100,
			DATA.ConsumableDescriptionFields.DAMAGE : 100,
			DATA.ConsumableDescriptionFields.AOE    : 1,
			DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		}
	}
]



func HOLY_MOLY_WEAPON() -> void: pass
const HOLY_MOLY_WEAPONS: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "oops", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named oops",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	}
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
