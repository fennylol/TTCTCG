extends Node3D

@onready var MainMenu = $MainMenu
@onready var PackZone = $PackZone
@onready var CollectionZone = $CollectionZone
@onready var MainCam = $MainCamera

enum Elements {MAINMENU, PACKZONE, COLLECTIONZONE}
func set_visible_element(Element: Elements):
	MainMenu.set_visible(true if Element == Elements.MAINMENU else false)
	
	MainCam.set_current(false if Element == Elements.PACKZONE else true)
	PackZone.set_visible(true if Element == Elements.PACKZONE else false)
	
	CollectionZone.set_visible(true if Element == Elements.COLLECTIONZONE else false)
	#MainCam.set_current(true if Element == Elements.COLLECTIONZONE else false)

func _ready() -> void: set_visible_element(Elements.MAINMENU)
func _on_pack_zone_finished() -> void: set_visible_element(Elements.MAINMENU)
func _on_collection_zone_finished() -> void: set_visible_element(Elements.MAINMENU)

func _on_pack_button_pressed() -> void:
	set_visible_element(Elements.PACKZONE)
	PackZone.DEBUG_add_pack()

func _on_collection_button_pressed() -> void:
	set_visible_element(Elements.COLLECTIONZONE)
	CollectionZone.display_collection()

func _on_pack_zone_results(ExpansionID: DATA.ExpansionIDs, CardList: Array[Card]) -> void:
	CollectionZone.recieve_cards(ExpansionID, CardList)
