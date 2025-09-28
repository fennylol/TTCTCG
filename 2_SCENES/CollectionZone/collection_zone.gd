extends Node3D

signal finished
signal UpdateNextPackTimer(prev_pack_time: float, next_pack_time: float)

@onready var UI: Control = $CollectionUI
const SLIDE_TARGET: float = -5.0

var WorkingCollection := ContentCollection.new()
#var DisplayGrid := ContentGrid.new(WorkingCollection)
var DisplayGrid := ContentGrid.new([])

enum ViewStates {COLLECTION, DECKLIST, DECK, CARDPAIRS}
var ViewState: ViewStates = ViewStates.COLLECTION

var SortingBy := ContentCollection.SortOrders.EXPANSION
var ShowingPrimary : bool = true
var LastAppliedCallable: Callable 
var LastCardList: Array[Card]


func enter_collection_zone(): begin_viewing_collection()

func _ready() -> void:
	#return
	var load_err: Error = WorkingCollection._load()
	if load_err == OK:
		add_child(WorkingCollection)
		WorkingCollection.set_name("WorkingCollection")
	else: 
		LOGGER.log_msg("collection failed to load: " + str(load_err), LOGGER.Flags.ERR_STDOUT)
		
	UI.delete_deck.connect(func(deck: Deck): WorkingCollection.delete_deck(deck.Name))
	UI.sorting_by.connect(func(SortOrder: ContentCollection.SortOrders): 
								SortingBy = SortOrder
								sort_grid())
	UI.showing_side.connect(func(Defense: bool): 
								ShowingPrimary = !Defense
								sort_grid())
#
func sort_grid(): new_grid(LastAppliedCallable, create_card_array(SortingBy), false if ViewState == ViewStates.COLLECTION else true)

func new_grid(callback: Callable, CardList: Array[Card], SlideToTheSide: bool = false):
	LastAppliedCallable = callback
	var y_pos = DisplayGrid.ScrollTarget
	var xStart = DisplayGrid.position.x 
	
	DisplayGrid.queue_free()
	
	DisplayGrid = ContentGrid.new(CardList)
	#DisplayGrid = ContentGrid.new(WorkingCollection, SortingBy, ShowingPrimary)
	
	DisplayGrid.set_name("DisplayGrid"+str(callback.hash()))
	DisplayGrid.CardClicked.connect(callback)
	DisplayGrid.position.y = y_pos
	DisplayGrid.position.x = xStart
	DisplayGrid.ScrollTarget = y_pos
	if SlideToTheSide: DisplayGrid.SlideTarget = SLIDE_TARGET
	
	add_child(DisplayGrid)


var _on_viewing_card_clicked: Callable
func begin_viewing_collection():
	ViewState = ViewStates.COLLECTION
	
	_on_viewing_card_clicked = func(_card: Card, _content_holder: ContentHolder):
		var _show_pair = func(card: Card, content_holder: ContentHolder):
			if card.position.y == 0:
				var old_pos = content_holder.position.y
				var return_to_zero = func(_string): 
					card.position.y = 0
					content_holder.position.y = old_pos
					new_grid(_on_viewing_card_clicked, create_card_array(SortingBy))
				card.play_anim("moves/PairSpin")
				content_holder.position.y -= 4.5
				if !card.AnimationComplete.is_connected(return_to_zero):
					card.AnimationComplete.connect(return_to_zero)
		new_grid(_show_pair, create_card_array_from_card(_card, SortingBy))
	new_grid(_on_viewing_card_clicked, create_card_array(SortingBy))


func begin_viewing_decks():
	ViewState = ViewStates.DECKLIST
	new_grid(func(_arg1, _arg2): pass, create_card_array(SortingBy), true)
	UI.recieve_deck_list(WorkingCollection.decks)

var _on_deck_building_card_clicked: Callable
func begin_building_deck(deck: Deck):
	ViewState = ViewStates.DECK
	UI.recieve_deck(deck)
	
	# attach card -> deck signal pathway
	_on_deck_building_card_clicked = func(card: Card, _content_holder: ContentHolder):
		var _select_pair = func(_card: Card, __content_holder: ContentHolder):
			assert(card is PlayablePair)
			var flipped_card : PlayablePair = PlayablePair.create_flipped_card(card)
			deck.add_to_deck(flipped_card)
			UI.recieve_card(flipped_card)
			new_grid(_on_deck_building_card_clicked, create_card_array(SortingBy), true)
		new_grid(_select_pair, create_card_array_from_card(card, SortingBy), true)
	new_grid(_on_deck_building_card_clicked, create_card_array(SortingBy), true)
	
	# attach deck -> collection pathway
	for connection in UI.deck_name_changed.get_connections(): UI.deck_name_changed.disconnect(connection.callable)
	UI.deck_name_changed.connect(func(new_name: String): deck.Name = new_name)
	
	for connection in UI.save_deck.get_connections(): UI.save_deck.disconnect(connection.callable)
	UI.save_deck.connect(func():
							WorkingCollection.recieve_deck(deck)
							if deck.Name != deck.LastSavedName:
								WorkingCollection.delete_deck(deck.LastSavedName)
								deck.LastSavedName = deck.Name)
	
	for connection in UI.RemoveCard.get_connections(): UI.RemoveCard.disconnect(connection.callable)
	UI.RemoveCard.connect(func(card: PlayablePair): deck.remove_from_deck(card))

# ==========
# ui signals
# ==========
func _on_collection_ui_building_button_toggled(state: bool) -> void:
	if state: begin_viewing_decks()
	else: begin_viewing_collection()

func _on_collection_ui_deck_selected(deck: Deck) -> void:
	if ViewState == ViewStates.DECKLIST:
		begin_building_deck(deck)

func _on_back_button_pressed() -> void: 
	ViewState = ViewStates.COLLECTION
	finished.emit()

func _on_reset_button_pressed() -> void:
	WorkingCollection.queue_free()
	WorkingCollection = ContentCollection.new()
	add_child(WorkingCollection)
	WorkingCollection.set_name("WorkingCollection")
	WorkingCollection._save()
	
	begin_viewing_collection()

func _on_visibility_changed() -> void:
	UI.set_visible(visible)


func create_card_array(SortOrder: ContentCollection.SortOrders) -> Array[Card]:
	var cards : Array[Card] = []
	var side: String = "ATK" if ShowingPrimary else "DEF"
	
	match SortOrder:
		ContentCollection.SortOrders.EXPANSION:
			for expansion in DATA.ExpansionIDs:
				for type in DATA.ContentTypes:
					for rarity in DATA.Rarities:
						for content_ID in WorkingCollection.collection[expansion][side][type][rarity]:
							var card: Card = DATA.get_expansion_content(DATA.ExpansionIDs[expansion], DATA.Rarities[rarity], DATA.ContentTypes[type], content_ID)
							cards.append(card)
		ContentCollection.SortOrders.TYPE:
			for type in DATA.ContentTypes:
				for rarity in DATA.Rarities:
					for expansion in DATA.ExpansionIDs:
						for content_ID in WorkingCollection.collection[expansion][side][type][rarity]:
							var card: Card = DATA.get_expansion_content(DATA.ExpansionIDs[expansion], DATA.Rarities[rarity], DATA.ContentTypes[type], content_ID)
							cards.append(card)
		ContentCollection.SortOrders.RARITY:
			for rarity in DATA.Rarities:
				for type in DATA.ContentTypes:
					for expansion in DATA.ExpansionIDs:
						for content_ID in WorkingCollection.collection[expansion][side][type][rarity]:
							var card: Card = DATA.get_expansion_content(DATA.ExpansionIDs[expansion], DATA.Rarities[rarity], DATA.ContentTypes[type], content_ID)
							cards.append(card)
	
	return cards

func create_card_array_from_card(StartingCard: Card, _SortOrder: ContentCollection.SortOrders) -> Array[Card]:
	var cards : Array[Card] = []
	var side: String = "ATK" if ShowingPrimary else "DEF"
	
	var expansion = DATA.ExpansionIDs.find_key(StartingCard.ExpansionID)
	var type = DATA.ContentTypes.find_key(StartingCard.Type)
	var rarity = DATA.Rarities.find_key(StartingCard.Rarity)
	var id = StartingCard.SetID

	for paired_rarity in DATA.Rarities:
		for paired_content_ID in WorkingCollection.collection[expansion][side][type][rarity][id][paired_rarity]:
			var paired_card: Card = DATA.get_expansion_content(DATA.ExpansionIDs[expansion], DATA.Rarities[paired_rarity], DATA.ContentTypes[type], paired_content_ID)
			cards.append(PlayablePair.create_from_two_cards(paired_card, StartingCard))
	
	return cards

## passthrough
func recieve_cards(ExpansionID : DATA.ExpansionIDs, CardList : Array[Card]): 
	WorkingCollection.recieve_cards(ExpansionID, CardList)
	UpdateNextPackTimer.emit(WorkingCollection.prev_pack_timestamp, WorkingCollection.prev_pack_timestamp+WorkingCollection.NEXT_PACK_UNIX_TIME_OFFSET)
