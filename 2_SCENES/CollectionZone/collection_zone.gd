extends Node3D

signal finished

@onready var UI: Control = $CollectionUI

var WorkingCollection := ContentCollection.new()
var DisplayGrid := ContentGrid.new(WorkingCollection)


func _ready() -> void:
	var load_err: Error = WorkingCollection._load()
	if load_err == OK:
		add_child(WorkingCollection)
		WorkingCollection.set_name("WorkingCollection")
	else: 
		printerr("collection failed to load: ", load_err)


func new_grid(callback: Callable, y_pos: float = 0.0):
	DisplayGrid.queue_free()
	DisplayGrid = ContentGrid.new(WorkingCollection)
	add_child(DisplayGrid)
	DisplayGrid.position.y = y_pos
	DisplayGrid.ScrollTarget = y_pos
	DisplayGrid.CardClicked.connect(callback)
	DisplayGrid.set_name("DisplayGrid"+str(callback.hash()))


func view_collection(y_pos: float = 0.0):
	var _on_viewing_card_clicked = func(card: Card, content_holder: ContentHolder):
		var how_many_kids: int = content_holder.get_child_count()-1
		print(card.name, " has ", how_many_kids, " kids")
		
		if card.position.y == 0:
			var old_pos = content_holder.position.y
			content_holder.position.y -= 4.5
			var return_to_zero = func(string): 
				card.position.y = 0
				content_holder.position.y = old_pos
			card.play_anim("moves/PairSpin")
			if !card.AnimationComplete.is_connected(return_to_zero):
				card.AnimationComplete.connect(return_to_zero)
	
	new_grid(_on_viewing_card_clicked, y_pos)

func build_deck(y_pos: float = 0.0):
	var _on_building_card_clicked = func(card: Card, content_holder: ContentHolder):
		print("added ", card.name, " to deck.")
	
	new_grid(_on_building_card_clicked, y_pos)



func _on_back_button_pressed() -> void: 
	finished.emit()

func _on_reset_button_pressed() -> void:
	WorkingCollection.queue_free()
	WorkingCollection = ContentCollection.new()
	add_child(WorkingCollection)
	WorkingCollection.set_name("WorkingCollection")
	WorkingCollection._save()
	
	view_collection()

func _on_visibility_changed() -> void:
	UI.set_visible(visible)

func _on_collection_ui_building_button_toggled(state: bool) -> void:
	var ScrollTarget = DisplayGrid.ScrollTarget
	build_deck(ScrollTarget) if state else view_collection(ScrollTarget)

func _on_collection_ui_sorting_by(SortOrder: ContentCollection.SortOrders) -> void:
	print("sorting by ", ContentCollection.SortOrders.find_key(SortOrder))
	# TODO: ADD LATER
	view_collection()


## passthrough
func recieve_cards(ExpansionID : DATA.ExpansionIDs, CardList : Array[Card]):
	WorkingCollection.recieve_cards(ExpansionID, CardList)
