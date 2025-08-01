extends Control

signal sorting_by (SortOrder: ContentCollection.SortOrders)
signal back_button_pressed
signal DEBUG_reset_button_pressed

@onready var SortOrderMenuButton = $VBoxContainer/TopBar/SortOrderMenu
var SortOrderMenu

func _ready() -> void:
	SortOrderMenu = SortOrderMenuButton.get_popup()
	
	var SortOrderSelected = func(idx: int):
		print("sorting by ", ContentCollection.SortOrders.find_key(idx))
		sorting_by.emit(idx)
	
	SortOrderMenu.index_pressed.connect(SortOrderSelected)

func _on_back_button_pressed() -> void: back_button_pressed.emit()
func _on_reset_button_pressed() -> void: DEBUG_reset_button_pressed.emit()
