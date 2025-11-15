extends Node3D

@onready var MainCam       : Camera3D           = $MainCamera
@onready var MainMenu      : MainUINode         = $MainUI
@onready var PackTimer     : PackTimerNode      = $PackTimer
@onready var PackZone      : PackZoneNode       = $ZoneZone/PackZone
@onready var GameZone      : GameZoneNode       = $ZoneZone/GameZone
@onready var CollectionZone: CollectionZoneNode = $ZoneZone/CollectionZone
enum Elements {MAINMENU, PACKZONE_PICKING, PACKZONE_PULLING, COLLECTIONZONE, GAMEZONE}

func _ready() -> void:
	get_tree().root.ready.connect(func(): get_tree().root.move_child(self, 0))
	get_tree().set_quit_on_go_back(false)
	get_tree().set_auto_accept_quit(false)
	
	set_visible_element(Elements.MAINMENU)
	
	DATA.DEBUG_print_prob_curve_EVs(DATA.Probabilities.BRUTAL)
	DATA.DEBUG_print_prob_curve_EVs(DATA.Probabilities.CURRENT_IDEAL)
	PackZone.DEBUG_roll_pack_odds(DATA.ExpansionIDs.INCHEFTION, 1000)
	PackZone.DEBUG_roll_pack_odds(DATA.ExpansionIDs.GASTROARCHEOLOGY, 1000)

# ========= #
# pack zone #
# ========= #
func _on_main_menu_pack_zone_button_pressed() -> void:
	set_visible_element(Elements.PACKZONE_PICKING)
	PackZone.enter_pack_zone()
func _on_pack_zone_starting() -> void: set_visible_element(Elements.PACKZONE_PULLING)
func _on_pack_zone_finished() -> void: set_visible_element(Elements.MAINMENU)
func _on_pack_zone_pack_pull_results(ExpansionID: DATA.ExpansionIDs, CardList: Array[Card]) -> void: 
	CollectionZone._to_content_collection_recieve_cards(ExpansionID, CardList)
# =============== #
# collection zone #
# =============== #
func _on_main_menu_collection_zone_button_pressed() -> void:
	set_visible_element(Elements.COLLECTIONZONE)
	CollectionZone.enter_collection_zone()
func _on_collection_zone_finished() -> void: set_visible_element(Elements.MAINMENU)

# ========= #
# game zone #
# ========= #
func _on_main_menu_game_zone_button_pressed() -> void:
	set_visible_element(Elements.GAMEZONE)
	GameZone.enter_game_zone()
func _on_game_zone_finished() -> void: set_visible_element(Elements.MAINMENU)

# ================ #
# internal utility #
# ================ #
func set_visible_element(Element: Elements):
	LOGGER.log_msg("main_zone.gd - set_visible_element(): setting " + Elements.find_key(Element) + " visible.")
	MainCam.set_current(false if Element == Elements.PACKZONE_PULLING else true)
	#MainCam.set_current(true)
	
	MainMenu.set_visible(      true if Element == Elements.MAINMENU                                                 else false)
	PackTimer.set_visible(     true if Element == Elements.MAINMENU         or Element == Elements.PACKZONE_PICKING else false)
	PackZone.set_visible(      true if Element == Elements.PACKZONE_PULLING or Element == Elements.PACKZONE_PICKING else false)
	CollectionZone.set_visible(true if Element == Elements.COLLECTIONZONE                                           else false)
	GameZone.set_visible(      true if Element == Elements.GAMEZONE                                                 else false)

func get_visible_element() -> Elements:
	if   MainMenu.visible:       return Elements.MAINMENU
	elif PackZone.visible:       return Elements.PACKZONE_PICKING if PackTimer.visible else Elements.PACKZONE_PULLING
	elif CollectionZone.visible: return Elements.COLLECTIONZONE
	elif GameZone.visible:       return Elements.GAMEZONE
	else:
		@warning_ignore("int_as_enum_without_match")
		return -1 as Elements

func _notification(what: int) -> void: 
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
			if LOGGER.MessageBoard.get_child_count() > 0:
				var child = LOGGER.MessageBoard.get_child(0)
				child.queue_free()
			elif MainMenu.visible:
				LOGGER.log_msg("main_zone.gd - notification_wm_go_back_request(): Recieved top level back button request.")
				#get_tree().quit()
			elif PackZone.visible:
				PackZone.finished.emit()
			elif CollectionZone.visible:
				CollectionZone._on_ui_back_button_pressed()
			elif GameZone.visible:
				GameZone.finished.emit()
		
	elif what == NOTIFICATION_WM_CLOSE_REQUEST:
		LOGGER.log_msg("main_zone.gd - notification_wm_close_request(): Quitting normally.")
		get_tree().quit()
