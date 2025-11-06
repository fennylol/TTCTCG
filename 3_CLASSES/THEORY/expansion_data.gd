class_name DATA
## a unified resources for storing and accessing expansion, pack, and content data


## the rarities for both packs and pack contents
enum Rarities                    {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY, HOLY_MOLY}
## the internal IDs for each expansion
enum ExpansionIDs                {TEST_SET, OTHER_SET, INCHEFTION}
## the fields of [member ExpansionData] 
enum ExpansionDataFields         {PACK_RARITY_ODDS, CONTENT_RARITY_ODDS, PACK_RARITY_CONTENT_COUNTS}
## the fields of [member ExpansionContent]
enum ExpansionContentFields      {NAME, IMAGE, STATS}
enum CritterDescriptionFields    {FLAVOR, HEALTH, DAMAGE, SPEED, EYESIGHT, HEARING, NATURE}
enum CritterNatures              {NORMAL, BRAVE, SKITTISH, HUNGRY, HELPFUL, VENGEFUL}
enum ConsumableDescriptionFields {FLAVOR, RANGE, DAMAGE, AOE, TARGET}
enum WeaponDescriptionFields     {FLAVOR, RANGE, DAMAGE, AMMO, ACCURACY, FIRERATE, TARGET}
enum Targets                     {ENEMY, ALLY, TERRAIN}
## the types of content. 
enum ContentTypes                {CRITTER, CONSUMABLE, WEAPON}
enum ContentSides                {TAKER, BAKER}


#ExpansionIDs.TEST_SET : {
	#ExpansionDataFields.PACK_RARITY_ODDS : [0.5, 0.28, 0.15, 0.05, 0.015, 0.005],
	#ExpansionDataFields.CONTENT_RARITY_ODDS : [
		#[0.5, 0.28, 0.15, 0.05, 0.015, 0.005],
		#[0.4, 0.38, 0.15, 0.05, 0.015, 0.005],
		#[0.3, 0.28, 0.35, 0.05, 0.015, 0.005],
		#[0.2, 0.28, 0.15, 0.35, 0.015, 0.005],
		#[0.1, 0.28, 0.15, 0.05, 0.415, 0.005],
		#[0.0, 0.28, 0.15, 0.05, 0.015, 0.505]
	#],
	#ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
#}
## metadata about expansions. contains pack and content rarity and content count per pack.[br]
## see [member ExpansionContent] for pack contents. 
const ExpansionData: Dictionary = {
	ExpansionIDs.INCHEFTION : {
		ExpansionDataFields.PACK_RARITY_ODDS : [0.564, 0.248, 0.109, 0.048, 0.021, 0.010], # exponential, B=0.44
		ExpansionDataFields.CONTENT_RARITY_ODDS : [
			[0.357, 0.341, 0.202, 0.080, 0.018, 0.002], # beta, A=2.05, S=4.25
			[0.287, 0.344, 0.235, 0.105, 0.026, 0.003], # beta, A=2.35, S=4.15
			[0.224, 0.336, 0.266, 0.133, 0.037, 0.004], # beta, A=2.65, S=4.05
			[0.170, 0.319, 0.291, 0.164, 0.051, 0.005], # beta, A=2.95, S=3.95
			[0.125, 0.294, 0.310, 0.196, 0.068, 0.007], # beta, A=3.25, S=3.85
			[0.090, 0.264, 0.321, 0.227, 0.088, 0.010]  # beta, A=3.55, S=3.75
		],
		ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
	},
	ExpansionIDs.TEST_SET : {
		ExpansionDataFields.PACK_RARITY_ODDS : [0.564, 0.248, 0.109, 0.048, 0.021, 0.010], # exponential, B=0.44
		ExpansionDataFields.CONTENT_RARITY_ODDS : [
			[0.389, 0.278, 0.179, 0.100, 0.044, 0.010], # beta, A=1.05, S=2
			[0.275, 0.277, 0.220, 0.142, 0.069, 0.017], # beta, A=1.55, S=2
			[0.180, 0.257, 0.249, 0.186, 0.101, 0.027], # beta, A=2.05, S=2
			[0.110, 0.221, 0.263, 0.227, 0.138, 0.041], # beta, A=2.55, S=2
			[0.063, 0.180, 0.261, 0.261, 0.177, 0.058], # beta, A=3.05, S=2
			[0.035, 0.139, 0.247, 0.285, 0.216, 0.078]  # beta, A=3.55, S=2
		],
		ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
	},
	ExpansionIDs.OTHER_SET : {
		ExpansionDataFields.PACK_RARITY_ODDS : [0.564, 0.248, 0.109, 0.048, 0.021, 0.010], # exponential, B=0.44
		ExpansionDataFields.CONTENT_RARITY_ODDS : [
			[0.389, 0.278, 0.179, 0.100, 0.044, 0.010], # beta, A=1.05, S=2
			[0.275, 0.277, 0.220, 0.142, 0.069, 0.017], # beta, A=1.55, S=2
			[0.180, 0.257, 0.249, 0.186, 0.101, 0.027], # beta, A=2.05, S=2
			[0.110, 0.221, 0.263, 0.227, 0.138, 0.041], # beta, A=2.55, S=2
			[0.063, 0.180, 0.261, 0.261, 0.177, 0.058], # beta, A=3.05, S=2
			[0.035, 0.139, 0.247, 0.285, 0.216, 0.078]  # beta, A=3.55, S=2
		],
		ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS : [2, 3, 5, 7, 11, 13]
	}
	#ExpansionIDs.TEST_SET : {
		#ExpansionDataFields.PACK_RARITY_ODDS : [],
		#ExpansionDataFields.CONTENT_RARITY_ODDS : [[],[],[],[],[],[]],
		#ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS : []
	#},
}

## data store of content from each expansion. [br]
## for expansion statistics, see [member ExpansionData]
const ExpansionContent: Dictionary = {
	ExpansionIDs.INCHEFTION : {
		Rarities.COMMON : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME  : "Bort", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/bort_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Bort",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME  : "Droopler", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/drooper_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Droopler",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME  : "Geppa", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/geppa_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Geppa",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME  : "Glormpus The Great Frog", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/glormpus_the_great_frog_HD.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "This big hungry frog wants his cake so FUCKING bad. He'll take a beating just to get some. (And he can fit a TON of cake in that big, fat, belly of his.)",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME  : "Smudge", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/smudge_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Smudge",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME  : "Snooflemander", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/snooflemander_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Snooflemander",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME  : "Tamray", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/0_Common/tamray_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Tamray",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named oops",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named oops",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		Rarities.UNCOMMON : {
			ContentTypes.CRITTER    : [
				{
					ExpansionContentFields.NAME : "Gepper", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/gepper_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Gepper",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Gubbi", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/gubbi_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Gubbi",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Horrorse", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/horrorse_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Horrorse",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Jooble", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/jooble_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Jooble",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Meeber", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/meeber_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Meeber",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Slorbor", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/slorbor_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Slorbor",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Weird Fish", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/weird_fish_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Weird",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named oops",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				},
				{
					ExpansionContentFields.NAME : "oops2", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named oops2",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON     : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named oops",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				},
				{
					ExpansionContentFields.NAME : "oops2", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named oops2",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		Rarities.RARE : {
			ContentTypes.CRITTER    : [
				{
					ExpansionContentFields.NAME : "Audisea", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/2_Rare/audisea_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Audisea",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Cathagaire", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/2_Rare/cathagaire_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Cathagaire",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Geppington", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/2_Rare/gepington_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Geppington",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Gooberta", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/2_Rare/gooberta_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Gooberta",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Smearzorg", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/2_Rare/smearzorg_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Smearzorg",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Zerlemoth", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/2_Rare/zerlemoth_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Zerlemoth",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Weirder Fish", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/InCHEFtion/1_Uncommon/weird_fish_sketch.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Weirder",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named oops",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON     : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named oops",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		Rarities.EPIC : {
			ContentTypes.CRITTER    : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named oops (epic)",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named oops",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON     : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named oops",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		Rarities.LEGENDARY : {
			ContentTypes.CRITTER    : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named oops",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named oops",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON     : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named oops",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		Rarities.HOLY_MOLY : {
			ContentTypes.CRITTER    : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named oops",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named oops",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON     : [
				{
					ExpansionContentFields.NAME : "oops", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/oops.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named oops",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		}
	},
	ExpansionIDs.TEST_SET : {
		Rarities.COMMON : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Glormpus The Great Frog", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/0_Common/TEST_SET/GlormpusTheGreatFrog.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Glormpus The Great Frog",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Rat", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/0_Common/TEST_SET/Rat.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Rat",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Regular Ol' Cigarette", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/0_Common/TEST_SET/RegularCigarette.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named Regular Ol' Cigarette",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Baseball Bat", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/0_Common/TEST_SET/BaseballBat.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named Baseball Bat",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		
		Rarities.UNCOMMON : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Greg", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/1_Uncommon/TEST_SET/Greg.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Greg",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Menthol Cigarette", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/1_Uncommon/TEST_SET/MentholCigarette.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named Menthol Cigarette",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Body Spray", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/1_Uncommon/TEST_SET/BodySpray.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named Body Spray",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		
		Rarities.RARE : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "The Weird Fish", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/2_Rare/TEST_SET/Weird_Fish.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named The Weird Fish",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Reliable Grenade", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/2_Rare/TEST_SET/ReliableGrenade.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named Reliable Grenade",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Zipper Lighter", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/2_Rare/TEST_SET/ZipperLighter.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named Zipper Lighter",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		
		Rarities.EPIC : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "The Weirder Fish", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/3_Epic/TEST_SET/Weirder_Fish.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named The Weirder Fish",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Molotov Mocktail", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/3_Epic/TEST_SET/MolotovMocktail.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named Molotov Mocktail",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Blood Blade", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/3_Epic/TEST_SET/BloodKnife.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named Blood Blade",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		
		Rarities.LEGENDARY : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Birb", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/4_Legendary/TEST_SET/Birb.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Birb",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Lump of Mold", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/4_Legendary/TEST_SET/PileOfMold.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named Lump of Mold",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Shrank Ray", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/4_Legendary/TEST_SET/ShrankRay.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named Shrank Ray",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		
		Rarities.HOLY_MOLY : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "The Man of Mud", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/5_Holy_Moly/TEST_SET/The_Man_of_Mud.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named The Man of Mud",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				},
				{
					ExpansionContentFields.NAME : "Snel", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/5_Holy_Moly/TEST_SET/Snel.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named ",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Chicken Nugget Dipped in Mystery Sauce", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/5_Holy_Moly/TEST_SET/ChickenNuggetInMysterySauce.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named Chicken Nugget Dipped in Mystery Sauce",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Stank Ray", 
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/5_Holy_Moly/TEST_SET/StankRay.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named Stank Ray",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		}, 
	},
	ExpansionIDs.OTHER_SET : {
		Rarities.COMMON : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Gumbus Dragon",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/0_Common/OTHER_SET/gumbus_dragon.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Gumbus Dragon",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Calming Flower",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/0_Common/OTHER_SET/calming_flower.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named Calming Flower",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Plain Knife",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/0_Common/OTHER_SET/plain_knife.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named Plain Knife",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		Rarities.UNCOMMON : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Brootiss",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/1_Uncommon/OTHER_SET/brutiss.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Brootiss",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Rock Candy",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/1_Uncommon/OTHER_SET/rock_candy.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named Rock Candy",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Reapers Scythe",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/1_Uncommon/OTHER_SET/reapers_scythe.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named Reapers Scythe",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		Rarities.RARE : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Stoomp",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/2_Rare/OTHER_SET/stoomp.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Stoomp",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Pile of Inordinate Wealth",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/2_Rare/OTHER_SET/pile_of_inordinate_wealth.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named Pile of Inordinate Wealth",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Burning Blade",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/2_Rare/OTHER_SET/burning_blade.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named Burning Blade",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		Rarities.EPIC : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Fat FLjck",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/3_Epic/OTHER_SET/fat_fLjck.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Fat FLjck",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Gents Glove",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/3_Epic/OTHER_SET/gents_glove.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named Gents Glove",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Liars Dice",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/3_Epic/OTHER_SET/liars_dice.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named Liars Dice",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		Rarities.LEGENDARY : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Gribble",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/4_Legendary/OTHER_SET/squee.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Gribble",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Flask of Tears",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/4_Legendary/OTHER_SET/flask_of_tears.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named Flask of Tears",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "Tome of Curses",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/4_Legendary/OTHER_SET/tome_of_curses.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named Tome of Curses",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		},
		Rarities.HOLY_MOLY : {
			ContentTypes.CRITTER : [
				{
					ExpansionContentFields.NAME : "Squee",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/5_Holy_Moly/OTHER_SET/gribble.png"),
					ExpansionContentFields.STATS : {
						CritterDescriptionFields.FLAVOR   : "a critter named Squee",
						CritterDescriptionFields.HEALTH   : 100,
						CritterDescriptionFields.SPEED    : 100,
						CritterDescriptionFields.DAMAGE   : 100,
						CritterDescriptionFields.EYESIGHT : 100,
						CritterDescriptionFields.HEARING  : 100,
						CritterDescriptionFields.NATURE : CritterNatures.NORMAL
					}
				}
			],
			ContentTypes.CONSUMABLE : [
				{
					ExpansionContentFields.NAME : "Flask of Beers",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/5_Holy_Moly/OTHER_SET/flask_of_beers.png"),
					ExpansionContentFields.STATS : {
						ConsumableDescriptionFields.FLAVOR : "a consumable named Flask of Beers",
						ConsumableDescriptionFields.RANGE  : 100,
						ConsumableDescriptionFields.DAMAGE : 100,
						ConsumableDescriptionFields.AOE    : 1,
						ConsumableDescriptionFields.TARGET : Targets.ENEMY
					}
				}
			],
			ContentTypes.WEAPON : [
				{
					ExpansionContentFields.NAME : "im not even kidding this staff is way too strong for you",
					ExpansionContentFields.IMAGE : preload("res://1_ASSETS/cards/art/5_Holy_Moly/OTHER_SET/im_not_even_kidding_this_staff_is_way_too_strong_for_you.png"),
					ExpansionContentFields.STATS : {
						WeaponDescriptionFields.FLAVOR   : "a weapon named im not even kidding this staff is way too strong for you",
						WeaponDescriptionFields.RANGE    : 100,
						WeaponDescriptionFields.DAMAGE   : 100,
						WeaponDescriptionFields.AMMO     : 10,
						WeaponDescriptionFields.ACCURACY : 100,
						WeaponDescriptionFields.FIRERATE : 100,
						WeaponDescriptionFields.TARGET   : Targets.ENEMY
					}
				}
			]
		}
	},
	#ExpansionIDs.OTHER_SET : {
		#Rarities.COMMON : {
			#ContentTypes.CRITTER : [{}],
			#ContentTypes.CONSUMABLE : [{}],
			#ContentTypes.WEAPON : [{}]
		#},
		#Rarities.UNCOMMON : {
			#ContentTypes.CRITTER : [{}],
			#ContentTypes.CONSUMABLE : [{}],
			#ContentTypes.WEAPON : [{}]
		#},
		#Rarities.RARE : {
			#ContentTypes.CRITTER : [{}],
			#ContentTypes.CONSUMABLE : [{}],
			#ContentTypes.WEAPON : [{}]
		#},
		#Rarities.EPIC : {
			#ContentTypes.CRITTER : [{}],
			#ContentTypes.CONSUMABLE : [{}],
			#ContentTypes.WEAPON : [{}]
		#},
		#Rarities.LEGENDARY : {
			#ContentTypes.CRITTER : [{}],
			#ContentTypes.CONSUMABLE : [{}],
			#ContentTypes.WEAPON : [{}]
		#},
		#Rarities.HOLY_MOLY : {
			#ContentTypes.CRITTER : [{}],
			#ContentTypes.CONSUMABLE : [{}],
			#ContentTypes.WEAPON : [{}]
		#}
	#}
}

## [b]Purpose[/b]: gets the odds for each rarity of pack to be generated for a specific expansion [br]
## from [constant ExpansionData] [br]
## [b]ExpansionID[/b]: the expansion for the pack being generated. (See [enum ExpansionIDs])[br]
## [b]Returns[/b]: an array of floats, indexed by [enum Rarities] representing the odds for each rarity to be[br]
## pulled
static func get_pack_rarity_odds(ExpansionID : ExpansionIDs) -> Array[float]:
	var arr: Array[float] = Array(ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_ODDS], TYPE_FLOAT, "", null)
	assert(abs(array_sum(arr)-1.0) <= 0.001, "pack odds != 1, "+ str(array_sum(arr)))
	return arr

## [b]Purpose[/b]: gets the odds for each content in a specific rarity of pack to be generated for a[br]
## specific expansion from [constant ExpansionData][br]
## [b]ExpansionID[/b]: the expansion for the pack being generated. (See [enum ExpansionIDs])[br]
## [b]PackRarity[/b]: the rarity for the pack being generated. (see [enum Rarities])[br]
## [b]Returns[/b]: an array of floats, indexed by [enum Rarities] representing the odds for each rarity to be[br]
## pulled
static func get_content_rarity_odds(ExpansionID : ExpansionIDs, PackRarity : Rarities) -> Array[float]: 
	var arr: Array[float] = Array(ExpansionData[ExpansionID][ExpansionDataFields.CONTENT_RARITY_ODDS][PackRarity], TYPE_FLOAT, "", null)
	assert(abs(array_sum(arr)-1.0) <= 0.001, "pack content odds != 1, " + str(array_sum(arr)))
	return arr


## [b]Purpose[/b]: gets the number of content contained in a rarity of pack of an expansion[br] 
## [b]ExpansionID[/b]: the expansion being queried. (See [enum ExpansionIDs])[br]
## [b]PackRarity[/b]: the rarity of the pack being queried. (see [enum Rarities])[br]
static func get_pack_content_count(ExpansionID : ExpansionIDs, PackRarity : Rarities) -> int:
	return ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS][PackRarity]


## [b]Purpose[/b]: gets the number of content contained in an expansion of a specified rarity[br] 
## [b]ExpansionID[/b]: the expansion being queried. (See [enum ExpansionIDs])[br]
## [b]ContentRarity[/b]: the rarity being queried. (see [enum Rarities])[br]
static func get_expansion_content_count(ExpansionID : ExpansionIDs, ContentRarity : Rarities, ContentType : ContentTypes) -> int:
	return ExpansionContent[ExpansionID][ContentRarity][ContentType].size()


## [b]Purpose[/b]: gets the data for a specified content from an expansion[br] 
## [b]ExpansionID[/b]: the expansion of the content being requested. (See [enum ExpansionIDs])[br]
## [b]ContentRarity[/b]: the rarity of the content being requested. (see [enum Rarities])[br]
## [b]ContentIndex[/b]: the index of the content being requested. (see [method get_expansion_content_count])
static func get_expansion_content(ExpansionID : ExpansionIDs, ContentRarity : Rarities, ContentType : ContentTypes, ContentIndex : int) -> Card:
	var data : Dictionary = ExpansionContent[ExpansionID][ContentRarity][ContentType][ContentIndex]
	return Card.new(
			ExpansionID,
			ContentRarity,
			ContentType,
			ContentIndex,
			data[ExpansionContentFields.NAME],
			data[ExpansionContentFields.IMAGE]
		)
static func get_paired_expansion_content(ExpansionID : ExpansionIDs, ContentRarity : Rarities, ContentType : ContentTypes, ContentIndex : int, \
										 PairedExpansionID : ExpansionIDs, PairedRarity : Rarities, PairedIndex  : int) -> PlayablePair:
	var data        : Dictionary = ExpansionContent[ExpansionID][ContentRarity][ContentType][ContentIndex]
	var paired_data : Dictionary = ExpansionContent[ExpansionID][PairedRarity][ContentType][PairedIndex]
	return PlayablePair.new(
		ExpansionID,
		ContentRarity,
		ContentType,
		ContentIndex,
		data[ExpansionContentFields.NAME],
		data[ExpansionContentFields.IMAGE],
		
		PairedExpansionID,
		PairedRarity,
		PairedIndex,
		paired_data[ExpansionContentFields.NAME],
		paired_data[ExpansionContentFields.IMAGE]
	)
static func get_content_stats(ExpansionID : ExpansionIDs, ContentRarity : Rarities, ContentType : ContentTypes, ContentIndex : int) -> Dictionary:
	return ExpansionContent[ExpansionID][ContentRarity][ContentType][ContentIndex][ExpansionContentFields.STATS]


static func calculate_expected_card_proportions_per_pack(expansion_id: ExpansionIDs) -> Array[float]:
	var pack_rarity_odds = get_pack_rarity_odds(expansion_id)
	
	# Get the number of card rarities by checking the first pack's content rarity odds
	var num_rarities = get_content_rarity_odds(expansion_id, 0 as Rarities).size()
	var expected_cards_per_rarity: Array[float] = []
	
	# Initialize array with zeros
	for i in range(num_rarities):
		expected_cards_per_rarity.append(0.0)
	
	# For each pack rarity
	for pack_rarity_int in range(pack_rarity_odds.size()):
		var pack_rarity = pack_rarity_int as Rarities
		var pack_probability = pack_rarity_odds[pack_rarity_int]
		var cards_per_pack = get_pack_content_count(expansion_id, pack_rarity)
		var content_rarity_odds = get_content_rarity_odds(expansion_id, pack_rarity)
		
		# For each card rarity
		for card_rarity in range(num_rarities):
			var card_rarity_odds = content_rarity_odds[card_rarity]
			
			# Expected number of this rarity cards in this pack type
			var expected_cards_in_pack = cards_per_pack * card_rarity_odds
			
			# Weight by pack probability and add to total
			expected_cards_per_rarity[card_rarity] += pack_probability * expected_cards_in_pack
	
	# Calculate total expected cards per pack to convert to proportions
	var total_expected_cards = 0.0
	for expected_count in expected_cards_per_rarity:
		total_expected_cards += expected_count
	
	# Convert to proportions
	var proportions: Array[float] = []
	for expected_count in expected_cards_per_rarity:
		proportions.append(expected_count / total_expected_cards)
	
	return proportions

static func get_color_from_rarity(Rarity: Rarities) -> Color:
	const RARITY_COLOR_S : float = 0.75
	const RARITY_COLOR_L : float = 0.75
	var RarityColors: Array[Color]  =  [Color.from_ok_hsl(000.0/360.0,            0.0, RARITY_COLOR_L),
										Color.from_ok_hsl(140.0/360.0, RARITY_COLOR_S, RARITY_COLOR_L), 
										Color.from_ok_hsl(215.0/360.0, RARITY_COLOR_S, RARITY_COLOR_L),
										Color.from_ok_hsl(290.0/360.0, RARITY_COLOR_S, RARITY_COLOR_L),
										Color.from_ok_hsl(005.0/360.0, RARITY_COLOR_S, RARITY_COLOR_L),
										Color.from_ok_hsl(080.0/360.0, RARITY_COLOR_S, RARITY_COLOR_L),
										Color.from_ok_hsl(000.0/360.0,            0.0,            0.5)]
	return RarityColors[Rarity]

static func create_rarity_material(rarity: Rarities) -> StandardMaterial3D:
	var color: Color = get_color_from_rarity(rarity)
	var img_size: int = 64
	var image = Image.create(img_size, img_size, false, Image.FORMAT_RGB8)
	
	for y in range(img_size): 
		for x in range(img_size):
			image.set_pixel(x, y, color)
	
	var texture = ImageTexture.new()
	texture.set_image(image)
	
	var material = StandardMaterial3D.new()
	material.albedo_texture = texture
	
	return material

static func create_paired_rarity_material(front_rarity: Rarities, back_rarity: Rarities) -> StandardMaterial3D:
	var front_color: Color = get_color_from_rarity(front_rarity)
	var back_color: Color = get_color_from_rarity(back_rarity)
	var img_size: int = 64
	var image = Image.create(img_size, img_size, false, Image.FORMAT_RGB8)
	
	for y in range(img_size): 
		for x in range(img_size):
			if x < img_size/2: image.set_pixel(x, y, front_color)
			else: image.set_pixel(x, y, back_color)
	
	var texture = ImageTexture.new()
	texture.set_image(image)
	
	var material = StandardMaterial3D.new()
	material.albedo_texture = texture
	
	return material

static func DEBUG_print_expansion_EVs(ExpansionID : ExpansionIDs) -> void:
	var expected_values := get_expansion_EVs(ExpansionID)
	
	LOGGER.log_msg("The average pack from " + ExpansionIDs.find_key(ExpansionID) + " will contain:")
	for rarity in Rarities:
		var r = Rarities[rarity]
		var Str: String = "├─ " if r != Rarities.HOLY_MOLY else "╰─ "
		LOGGER.log_msg(Str + str(expected_values[r]) + " " + rarity + " cards")
	LOGGER.log_msg("and an average of " + str(array_sum(expected_values)) + " total cards.\n")

static func get_expansion_EVs(ExpansionID : ExpansionIDs) -> Array[float]:
	var expected_values: Array[float] = [0, 0, 0, 0, 0, 0]
	for pack_tier in range(Rarities.size()):
		var pack_probability = ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_ODDS][pack_tier]
		var pack_card_count = ExpansionData[ExpansionID][ExpansionDataFields.PACK_RARITY_CONTENT_COUNTS][pack_tier]
		for card_tier in range(Rarities.size()):
			var card_probability = ExpansionData[ExpansionID][ExpansionDataFields.CONTENT_RARITY_ODDS][pack_tier][card_tier]
			expected_values[card_tier] += pack_probability * pack_card_count * card_probability
	return expected_values
	

## [b]Purpose[/b]: sums all elements of an array of floats. Used for internal testing.[br]
## [b]Arr[/b]: an array of floats[br]
## [b]Returns[/b]: the sum 
static func array_sum(Arr: Array[float]) -> float:
	var sum: float = 0.0
	for f in Arr: sum+=f
	return sum

static func array_sum_i(Arr: Array[int]) -> int:
	var sum: int = 0
	for f in Arr: sum+=f
	return sum
