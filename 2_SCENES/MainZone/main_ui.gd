extends Node3D

@onready var MainCam = $MainCamera
@onready var MainMenu: MainUINode = $MainUI
@onready var PackZone: PackZoneNode = $ZoneZone/PackZone
@onready var GameZone: GameZoneNode = $ZoneZone/GameZone
@onready var CollectionZone: CollectionZoneNode = $ZoneZone/CollectionZone
enum Elements {MAINMENU, PACKZONE, COLLECTIONZONE, GAMEZONE}


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("DEBUG_ACTION"):
		print("\n\n\nORPHAMS")
		print_orphan_nodes()

func _ready() -> void:
	get_tree().set_quit_on_go_back(false)
	get_tree().set_auto_accept_quit(false)
	set_visible_element(Elements.MAINMENU)
	MainMenu._recieve_pack_timer(CollectionZone.WorkingCollection.next_pack_timestamp, CollectionZone.WorkingCollection.pack_after_that_timestamp)	
	#DATA.DEBUG_print_expansion_EVs(DATA.ExpansionIDs.TEST_SET)
	#PackZone.DEBUG_roll_pack_odds(DATA.ExpansionIDs.TEST_SET)
	#DATA.DEBUG_print_expansion_EVs(DATA.ExpansionIDs.OTHER_SET)
	#PackZone.DEBUG_roll_pack_odds(DATA.ExpansionIDs.OTHER_SET)
# ========= #
# pack zone #
# ========= #
func _on_main_menu_pack_button_pressed() -> void:
	if CollectionZone.WorkingCollection.next_pack_timestamp < Time.get_unix_time_from_system():
		set_visible_element(Elements.PACKZONE)
		PackZone.enter_pack_zone()
func _on_pack_zone_results(ExpansionID: DATA.ExpansionIDs, CardList: Array[Card]) -> void:
	CollectionZone._to_content_collection_recieve_cards(ExpansionID, CardList)
	MainMenu._recieve_pack_timer(CollectionZone.WorkingCollection.next_pack_timestamp, CollectionZone.WorkingCollection.pack_after_that_timestamp)
func _on_pack_zone_finished() -> void: set_visible_element(Elements.MAINMENU)
# =============== #
# collection zone #
# =============== #
func _on_main_menu_collection_button_pressed() -> void:
	set_visible_element(Elements.COLLECTIONZONE)
	CollectionZone.enter_collection_zone()
func _on_collection_zone_finished() -> void: set_visible_element(Elements.MAINMENU)
# ========= #
# game zone #
# ========= #
func _on_main_menu_play_button_pressed() -> void:
	set_visible_element(Elements.GAMEZONE)
	GameZone.enter_game_zone(CollectionZone.WorkingCollection.decks)
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

func get_visible_element() -> Elements:
	if   MainMenu.visible:       return Elements.MAINMENU
	elif PackZone.visible:       return Elements.PACKZONE
	elif CollectionZone.visible: return Elements.COLLECTIONZONE
	elif GameZone.visible:       return Elements.GAMEZONE
	else:
		@warning_ignore("int_as_enum_without_match")
		return -1 as Elements

func _notification(what: int) -> void: 
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
			if MainMenu.visible:
				LOGGER.log_msg("main_zone.gd: Quitting by back button request.")
				get_tree().quit()
			elif PackZone.visible:
				PackZone.finished.emit()
			elif CollectionZone.visible:
				CollectionZone._on_ui_back_button_pressed()
			elif GameZone.visible:
				GameZone.finished.emit()
		
	elif what == NOTIFICATION_WM_CLOSE_REQUEST:
		LOGGER.log_msg("main_zone.gd: Quitting normally.")
		get_tree().quit()
		print_orphan_nodes()
