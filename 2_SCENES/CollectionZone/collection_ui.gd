extends Control

signal sorting_by (SortOrder: ContentCollection.SortOrders)
signal back_button_pressed
signal building_button_toggled (state: bool)
signal DEBUG_reset_button_pressed

@onready var SortOrderMenuButton = $VBoxContainer/TopBar/SortOrderMenu
var SortOrderMenu

func _ready() -> void:
	SortOrderMenu = SortOrderMenuButton.get_popup()
	SortOrderMenu.index_pressed.connect(sorting_by.emit)


func _on_back_button_pressed() -> void: back_button_pressed.emit()
func _on_reset_button_pressed() -> void: DEBUG_reset_button_pressed.emit()
func _on_check_button_toggled(toggled_on: bool) -> void: building_button_toggled.emit(toggled_on)
