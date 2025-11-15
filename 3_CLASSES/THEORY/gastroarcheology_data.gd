#const SAMPLE_CRITTERS: Array[Dictionary] = [
	#{
		#DATA.ExpansionContentFields.NAME : "oops", 
		#DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/oops.png"),
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
		#DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/oops.png"),
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
		#DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/oops.png"),
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

# DATA.Rarities                   
# DATA.ProbabilityCurveFields        
# DATA.ExpansionContentFields     
# DATA.CritterDescriptionFields   
# DATA.CritterNatures             
# DATA.ConsumableDescriptionFields
# DATA.WeaponDescriptionFields    
# DATA.Targets                    
# DATA.ContentTypes   

class_name GastroArcheologyData

func COMMON_CRITTER() -> void: pass
const COMMON_CRITTERS: Array[Dictionary] = [
	{
		DATA.ExpansionContentFields.NAME : "Glormpus The Great Frog", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/0_Common/GlormpusTheGreatFrog.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Glormpus The Great Frog",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Rat", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/0_Common/Rat.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Rat",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Gumbus Dragon",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/0_Common/gumbus_dragon.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Gumbus Dragon",
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
		DATA.ExpansionContentFields.NAME : "Regular Ol' Cigarette", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/0_Common/RegularCigarette.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named Regular Ol' Cigarette",
			DATA.ConsumableDescriptionFields.RANGE  : 100,
			DATA.ConsumableDescriptionFields.DAMAGE : 100,
			DATA.ConsumableDescriptionFields.AOE    : 1,
			DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Calming Flower",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/0_Common/calming_flower.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named Calming Flower",
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
		DATA.ExpansionContentFields.NAME : "Baseball Bat", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/0_Common/BaseballBat.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named Baseball Bat",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Plain Knife",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/0_Common/plain_knife.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named Plain Knife",
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
		DATA.ExpansionContentFields.NAME : "Greg", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/1_Uncommon/Greg.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Greg",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Brootiss",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/1_Uncommon/brutiss.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Brootiss",
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
		DATA.ExpansionContentFields.NAME : "Menthol Cigarette", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/1_Uncommon/MentholCigarette.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named Menthol Cigarette",
			DATA.ConsumableDescriptionFields.RANGE  : 100,
			DATA.ConsumableDescriptionFields.DAMAGE : 100,
			DATA.ConsumableDescriptionFields.AOE    : 1,
			DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Rock Candy",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/1_Uncommon/rock_candy.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named Rock Candy",
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
		DATA.ExpansionContentFields.NAME : "Body Spray", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/1_Uncommon/BodySpray.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named Body Spray",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Reapers Scythe",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/1_Uncommon/reapers_scythe.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named Reapers Scythe",
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
		DATA.ExpansionContentFields.NAME : "The Weird Fish", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/2_Rare/Weird_Fish.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named The Weird Fish",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Stoomp",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/2_Rare/stoomp.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Stoomp",
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
		DATA.ExpansionContentFields.NAME : "Reliable Grenade", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/2_Rare/ReliableGrenade.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named Reliable Grenade",
			DATA.ConsumableDescriptionFields.RANGE  : 100,
			DATA.ConsumableDescriptionFields.DAMAGE : 100,
			DATA.ConsumableDescriptionFields.AOE    : 1,
			DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Pile of Inordinate Wealth",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/2_Rare/pile_of_inordinate_wealth.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named Pile of Inordinate Wealth",
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
		DATA.ExpansionContentFields.NAME : "Zipper Lighter", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/2_Rare/ZipperLighter.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named Zipper Lighter",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Burning Blade",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/2_Rare/burning_blade.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named Burning Blade",
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
		DATA.ExpansionContentFields.NAME : "The Weirder Fish", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/3_Epic/Weirder_Fish.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named The Weirder Fish",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Fat FLjck",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/3_Epic/fat_fLjck.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Fat FLjck",
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
		DATA.ExpansionContentFields.NAME : "Molotov Mocktail", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/3_Epic/MolotovMocktail.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named Molotov Mocktail",
			DATA.ConsumableDescriptionFields.RANGE  : 100,
			DATA.ConsumableDescriptionFields.DAMAGE : 100,
			DATA.ConsumableDescriptionFields.AOE    : 1,
			DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Gents Glove",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/3_Epic/gents_glove.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named Gents Glove",
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
		DATA.ExpansionContentFields.NAME : "Blood Blade", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/3_Epic/BloodKnife.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named Blood Blade",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Liars Dice",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/3_Epic/liars_dice.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named Liars Dice",
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
		DATA.ExpansionContentFields.NAME : "Birb", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/4_Legendary/Birb.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Birb",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Gribble",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/4_Legendary/squee.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Gribble",
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
		DATA.ExpansionContentFields.NAME : "Lump of Mold", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/4_Legendary/PileOfMold.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named Lump of Mold",
			DATA.ConsumableDescriptionFields.RANGE  : 100,
			DATA.ConsumableDescriptionFields.DAMAGE : 100,
			DATA.ConsumableDescriptionFields.AOE    : 1,
			DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Flask of Tears",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/4_Legendary/flask_of_tears.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named Flask of Tears",
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
		DATA.ExpansionContentFields.NAME : "Shrank Ray", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/4_Legendary/ShrankRay.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named Shrank Ray",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Tome of Curses",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/4_Legendary/tome_of_curses.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named Tome of Curses",
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
		DATA.ExpansionContentFields.NAME : "The Man of Mud", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/5_Holy_Moly/The_Man_of_Mud.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named The Man of Mud",
			DATA.CritterDescriptionFields.HEALTH   : 100,
			DATA.CritterDescriptionFields.SPEED    : 100,
			DATA.CritterDescriptionFields.DAMAGE   : 100,
			DATA.CritterDescriptionFields.EYESIGHT : 100,
			DATA.CritterDescriptionFields.HEARING  : 100,
			DATA.CritterDescriptionFields.NATURE : DATA.CritterNatures.NORMAL
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Snel", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/5_Holy_Moly/Snel.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named ",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Squee",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/5_Holy_Moly/gribble.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.CritterDescriptionFields.FLAVOR   : "a critter named Squee",
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
		DATA.ExpansionContentFields.NAME : "Chicken Nugget Dipped in Mystery Sauce", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/5_Holy_Moly/ChickenNuggetInMysterySauce.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named Chicken Nugget Dipped in Mystery Sauce",
			DATA.ConsumableDescriptionFields.RANGE  : 100,
			DATA.ConsumableDescriptionFields.DAMAGE : 100,
			DATA.ConsumableDescriptionFields.AOE    : 1,
			DATA.ConsumableDescriptionFields.TARGET : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "Flask of Beers",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/5_Holy_Moly/flask_of_beers.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.ConsumableDescriptionFields.FLAVOR : "a consumable named Flask of Beers",
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
		DATA.ExpansionContentFields.NAME : "Stank Ray", 
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/5_Holy_Moly/StankRay.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named Stank Ray",
			DATA.WeaponDescriptionFields.RANGE    : 100,
			DATA.WeaponDescriptionFields.DAMAGE   : 100,
			DATA.WeaponDescriptionFields.AMMO     : 10,
			DATA.WeaponDescriptionFields.ACCURACY : 100,
			DATA.WeaponDescriptionFields.FIRERATE : 100,
			DATA.WeaponDescriptionFields.TARGET   : DATA.Targets.ENEMY
		}
	},
	{
		DATA.ExpansionContentFields.NAME : "im not even kidding this staff is way too strong for you",
		DATA.ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/GastroArcheology/5_Holy_Moly/im_not_even_kidding_this_staff_is_way_too_strong_for_you.png"),
		DATA.ExpansionContentFields.STATS : {
			DATA.WeaponDescriptionFields.FLAVOR   : "a weapon named im not even kidding this staff is way too strong for you",
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
