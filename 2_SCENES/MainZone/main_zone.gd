extends Node3D

@onready var MainCam = $MainCamera
@onready var MainMenu = $MainMenu
@onready var PackZone = $ZoneZone/PackZone
@onready var GameZone = $ZoneZone/GameZone
@onready var CollectionZone = $ZoneZone/CollectionZone
enum Elements {MAINMENU, PACKZONE, COLLECTIONZONE, GAMEZONE}

func _ready() -> void: 
	set_visible_element(Elements.MAINMENU)
	
	DATA.DEBUG_print_expansion_EVs(DATA.ExpansionIDs.TEST_SET)
	PackZone.DEBUG_roll_pack_odds(DATA.ExpansionIDs.TEST_SET)
	
	DATA.DEBUG_print_expansion_EVs(DATA.ExpansionIDs.OTHER_SET)
	PackZone.DEBUG_roll_pack_odds(DATA.ExpansionIDs.OTHER_SET)
# ========= #
# pack zone #
# ========= #
func _on_main_menu_pack_button_pressed() -> void:
	set_visible_element(Elements.PACKZONE)
	PackZone.enter_pack_zone()
func _on_pack_zone_results(ExpansionID: DATA.ExpansionIDs, CardList: Array[Card]) -> void:
	CollectionZone._to_content_collection_recieve_cards(ExpansionID, CardList)
func _on_pack_zone_finished() -> void: set_visible_element(Elements.MAINMENU)
# =============== #
# collection zone #
# =============== #
func _on_main_menu_collection_button_pressed() -> void:
	set_visible_element(Elements.COLLECTIONZONE)
	CollectionZone.enter_collection_zone()
func _on_collection_zone_update_next_pack_timer(prev_pack_time: float, next_pack_time: float) -> void: MainMenu.update_next_pack_timer(prev_pack_time, next_pack_time)
func _on_collection_zone_finished() -> void: set_visible_element(Elements.MAINMENU)
# ========= #
# game zone #
# ========= #
func _on_main_menu_play_button_pressed() -> void:
	set_visible_element(Elements.GAMEZONE)
	GameZone.enter_game_zone()
func _on_game_zone_finished() -> void: set_visible_element(Elements.MAINMENU)

# ======= #
# utility #
# ======= #
func set_visible_element(Element: Elements):
	MainCam.set_current(false if Element == Elements.PACKZONE else true)
	PackZone.set_visible(true if Element == Elements.PACKZONE else false)
	CollectionZone.set_visible(true if Element == Elements.COLLECTIONZONE else false)
	GameZone.set_visible(true if Element == Elements.GAMEZONE else false)
	MainMenu.set_visible(true if Element == Elements.MAINMENU else false)
