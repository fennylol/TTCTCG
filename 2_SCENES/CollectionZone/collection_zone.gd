extends Node3D

signal finished

@onready var UI: Control = $CollectionUI
const SLIDE_TARGET: float = -5.0

var WorkingCollection := ContentCollection.new()
var DisplayGrid := ContentGrid.new(WorkingCollection)

enum ViewStates {COLLECTION, DECKLIST, DECK}
var ViewState: ViewStates = ViewStates.COLLECTION

func _ready() -> void:
	#return
	var load_err: Error = WorkingCollection._load()
	if load_err == OK:
		add_child(WorkingCollection)
		WorkingCollection.set_name("WorkingCollection")
	else: 
		printerr("collection failed to load: ", load_err)
	#UI.delete_deck.connect(func(deck: Deck): WorkingCollection.delete_deck(deck.Name))


func new_grid(callback: Callable, SlideToTheSide: bool = false):
	var y_pos = DisplayGrid.ScrollTarget
	var xStart = DisplayGrid.position.x 
	
	DisplayGrid.queue_free()
	DisplayGrid = ContentGrid.new(WorkingCollection)
	
	DisplayGrid.set_name("DisplayGrid"+str(callback.hash()))
	DisplayGrid.CardClicked.connect(callback)
	DisplayGrid.position.y = y_pos
	DisplayGrid.position.x = xStart
	DisplayGrid.ScrollTarget = y_pos
	if SlideToTheSide: DisplayGrid.SlideTarget = SLIDE_TARGET
	
	add_child(DisplayGrid)


func view_collection():
	ViewState = ViewStates.COLLECTION
	var _on_viewing_card_clicked = func(card: Card, content_holder: ContentHolder):
		var how_many_kids: int = content_holder.get_child_count()-1
		print(card.name, " has ", how_many_kids, " kids")
		
		if card.position.y == 0:
			var old_pos = content_holder.position.y
			content_holder.position.y -= 4.5
			var return_to_zero = func(_string): 
				card.position.y = 0
				content_holder.position.y = old_pos
			card.play_anim("moves/PairSpin")
			if !card.AnimationComplete.is_connected(return_to_zero):
				card.AnimationComplete.connect(return_to_zero)
	
	new_grid(_on_viewing_card_clicked)

func view_decks():
	ViewState = ViewStates.DECKLIST
	new_grid(func(_arg1, _arg2): pass, true)
	
	UI.recieve_deck_list(WorkingCollection.decks)

func select_deck(deck: Deck):
	ViewState = ViewStates.DECK
	UI.recieve_deck(deck)
	
	# attach card -> deck signal pathway
	var _on_building_deck_card_clicked = func(card: Card, _content_holder: ContentHolder):
		deck.add_to_deck(PlayablePair.create_from_two_cards(card, card))
		UI.recieve_card(card)
	new_grid(_on_building_deck_card_clicked, true)
	
	# attach deck -> collection pathway
	UI.deck_name_changed.connect(func(new_name: String): deck.Name = new_name)
	UI.save_deck.connect(func():
							WorkingCollection.recieve_deck(deck)
							if deck.Name != deck.LastSavedName:
								WorkingCollection.delete_deck(deck.LastSavedName)
								deck.LastSavedName = deck.Name)

# ==========
# ui signals
# ==========
func _on_collection_ui_building_button_toggled(state: bool) -> void:
	if state: view_decks()
	else: view_collection()

func _on_collection_ui_deck_selected(deck: Deck) -> void:
	if ViewState == ViewStates.DECKLIST:
		select_deck(deck)
		
		if deck.Name == "New Deck":
			print("making new deck")
		else:
			print("viewing deck: ", deck.Name)


func _on_back_button_pressed() -> void: 
	ViewState = ViewStates.COLLECTION
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

func _on_collection_ui_sorting_by(SortOrder: ContentCollection.SortOrders) -> void:
	print("sorting by ", ContentCollection.SortOrders.find_key(SortOrder))
	# TODO: ADD LATER
	view_collection()


## passthrough
func recieve_cards(ExpansionID : DATA.ExpansionIDs, CardList : Array[Card]):
	WorkingCollection.recieve_cards(ExpansionID, CardList)
