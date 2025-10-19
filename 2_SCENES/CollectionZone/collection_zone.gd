extends Node3D
class_name CollectionZoneNode

signal finished

@onready var DisplayGrid: ContentGrid = $ContentGrid
@onready var UI: CollectionUINode = $CollectionUI
var WorkingCollection := ContentCollection.new()

enum ViewStates {COLLECTION, COLLECTIONCARDPAIRS, DECKLIST, DECKLISTCARDPAIRS, DECK, DECKCARDPAIRS, UN_CARD_PAIR_ME = -1}
var ViewState: ViewStates = ViewStates.COLLECTION
var WorkingDeck: Deck

var SortingOrder := ContentCollection.SortOrders.EXPANSION
var ShowingSecondary: bool = false

func _ready() -> void:
	#return
	var load_err: Error = WorkingCollection._load()
	if load_err == OK:
		WorkingCollection.set_name("WorkingCollection")
		add_child(WorkingCollection)
		_to_display_grid_send_card_list()
	else: 
		WorkingCollection.queue_free()
		WorkingCollection = ContentCollection.new()
		LOGGER.log_msg("collection_zone.gd: collection failed to load: " + str(load_err), LOGGER.Flags.ERR_STDOUT)

func enter_collection_zone():
	change_view_state(ViewStates.COLLECTION)
	_to_ui_show_collection()
	_to_display_grid_send_card_list()

# ============== #
# USER INTERFACE #
# ============== #
#region
func _on_ui_DEBUG_reset_button_pressed() -> void: 
	WorkingCollection.queue_free()
	WorkingCollection = ContentCollection.new()
	add_child(WorkingCollection)
	WorkingCollection.set_name("WorkingCollection")
	WorkingCollection._save()
	enter_collection_zone()
# SIGNAL RECEPTION
func _on_ui_back_button_pressed() -> void: 
	match ViewState:
		ViewStates.COLLECTION: 
			change_view_state(ViewStates.COLLECTION)
			finished.emit()
		ViewStates.COLLECTIONCARDPAIRS:
			change_view_state(ViewStates.COLLECTION)
			_to_ui_show_collection()
			_to_display_grid_send_card_list()
		
		ViewStates.DECKLIST:
			change_view_state(ViewStates.COLLECTION)
			_to_ui_show_collection()
		ViewStates.DECKLISTCARDPAIRS:
			change_view_state(ViewStates.DECKLIST)
			_to_ui_passthrough_show_decks()
		
		ViewStates.DECK:
			change_view_state(ViewStates.DECKLIST)
			WorkingDeck = null
			_to_ui_passthrough_show_decks()
		ViewStates.DECKCARDPAIRS:
			change_view_state(ViewStates.DECK)
	_to_display_grid_send_card_list()
func _on_ui_show_decks_button_pressed()                                   -> void: change_view_state(ViewStates.DECKLIST)        ; _to_ui_passthrough_show_decks()   ; _to_display_grid_send_card_list()
func _on_ui_show_collection_button_pressed()                              -> void: change_view_state(ViewStates.COLLECTION)      ; _to_ui_show_collection()          ; _to_display_grid_send_card_list()
func _on_ui_sort_order_selected(sort_order: ContentCollection.SortOrders) -> void: change_view_state(ViewStates.UN_CARD_PAIR_ME) ; SortingOrder = sort_order         ; _to_display_grid_send_card_list()
func _on_ui_show_side_selected(show_secondary: bool)                      -> void: change_view_state(ViewStates.UN_CARD_PAIR_ME) ; ShowingSecondary = show_secondary ; _to_display_grid_send_card_list()
func _on_ui_passthrough_select_deck(deck: Deck)                           -> void: 
	change_view_state(ViewStates.DECK)
	WorkingDeck = deck
	_to_display_grid_send_card_list()
	_to_ui_passthrough_show_deck_content(deck)
func _on_ui_passthrough_save_deck()                   -> void: _to_content_collection_save_deck()
func _on_ui_passthrough_rename_deck(new_name: String) -> void: _to_content_collection_rename_deck(new_name)
func _on_ui_passthrough_delete_deck()                 -> void: _to_content_collection_delete_deck()
func _on_ui_passthrough_select_card(card: Dictionary) -> void: _to_ui_remove_card_from_deck(card)
# CALL EMISSION
func _to_ui_show_collection()                              -> void: UI._show_collection()
func _to_ui_passthrough_show_decks()                       -> void: UI._passthrough_to_deckdisplay_show_decks(WorkingCollection.decks)
func _to_ui_passthrough_show_deck_content(deck: Deck)      -> void: UI._passthrough_to_deckdisplay_show_deck_content(deck)
func _to_ui_passthrough_add_card_to_deck(card: Dictionary) -> void: UI._passthrough_to_deckdisplay_add_card_to_deck(card)
func _to_ui_remove_card_from_deck(card: Dictionary)        -> void: 
	WorkingDeck.remove_from_deck(card)
	UI._passthrough_to_deckdisplay_remove_card_from_deck(card)
	_to_display_grid_send_exclusions()
#endregion

# ============ #
# DISPLAY GRID #
# ============ #
#region
# SIGNAL RECEPTION
func _on_display_grid_card_clicked(card: Card, content_holder: ContentHolder) -> void: 
	var card_spin = func(next_view_state: ViewStates):
		if card.position.y == 0:
			var old_pos = content_holder.position.y
			var return_to_zero = func(_string): 
				card.position.y = 0
				content_holder.position.y = old_pos
				change_view_state(next_view_state)
				_to_display_grid_send_card_list()
			card.play_anim("moves/PairSpin")
			content_holder.position.y -= 4.5
			if !card.AnimationComplete.is_connected(return_to_zero):
				card.AnimationComplete.connect(return_to_zero)
	
	match ViewState:
		ViewStates.COLLECTION:
			LOGGER.log_msg("collection_zone.gd: " + card.Name + " clicked in COLLECTION", LOGGER.Flags.MSG_STDOUT)
			change_view_state(ViewStates.COLLECTIONCARDPAIRS)
			_to_display_grid_send_card_list_from_card(card)
		ViewStates.COLLECTIONCARDPAIRS:
			LOGGER.log_msg("collection_zone.gd: " + card.Name + " clicked in COLLECTIONCARDPAIRS", LOGGER.Flags.MSG_STDOUT)
			card_spin.call(ViewStates.COLLECTION)
		
		ViewStates.DECKLIST:
			LOGGER.log_msg("collection_zone.gd: " + card.Name + " clicked in DECKLIST", LOGGER.Flags.MSG_STDOUT)
			change_view_state(ViewStates.DECKLISTCARDPAIRS)
			_to_display_grid_send_card_list_from_card(card)
		ViewStates.DECKLISTCARDPAIRS:
			LOGGER.log_msg("collection_zone.gd: " + card.Name + " clicked in DECKLISTCARDPAIRS", LOGGER.Flags.MSG_STDOUT)
			card_spin.call(ViewStates.DECKLIST)
		
		ViewStates.DECK:
			LOGGER.log_msg("collection_zone.gd: " + card.Name + " clicked in DECK", LOGGER.Flags.MSG_STDOUT)
			change_view_state(ViewStates.DECKCARDPAIRS)
			_to_display_grid_send_card_list_from_card(card)
		ViewStates.DECKCARDPAIRS:
			LOGGER.log_msg("collection_zone.gd: " + card.Name + " clicked in DECKCARDPAIRS", LOGGER.Flags.MSG_STDOUT)
			assert(card is PlayablePair, "Clicked card is not PlayablePair")
			var card_dict = (card as PlayablePair).reduce_to_dict() if ShowingSecondary else (card as PlayablePair).reduce_to_dict(true)
			WorkingDeck.add_to_deck(card_dict)
			_to_ui_passthrough_add_card_to_deck(card_dict)
			_to_display_grid_send_card_list()
			change_view_state(ViewStates.DECK)
# CALL EMISSION
func _to_display_grid_send_card_list()                     -> void: DisplayGrid._recieve_card_list(create_card_array())               ; _to_display_grid_send_exclusions() 
func _to_display_grid_send_card_list_from_card(card: Card) -> void: DisplayGrid._recieve_card_list(create_card_array_from_card(card)) ; _to_display_grid_send_exclusions() 
func _to_display_grid_send_exclusions()                    -> void: DisplayGrid._recieve_exclusion_list(create_exclusion_list())
#endregion

# ================== #
# CONTENT COLLECTION #
# ================== #
#region
# CALL EMISSION
func _to_content_collection_recieve_cards(ExpansionID : DATA.ExpansionIDs,
										  CardList : Array[Card]) -> void: WorkingCollection.recieve_cards(ExpansionID, CardList)
func _to_content_collection_save_deck()                           -> void: WorkingCollection.recieve_deck(WorkingDeck)
func _to_content_collection_delete_deck()                         -> void: WorkingCollection.delete_deck(WorkingDeck.Name)
func _to_content_collection_rename_deck(new_name: String)         -> void: 
	_to_content_collection_delete_deck()
	WorkingDeck.Name = new_name
	_to_content_collection_save_deck()
#endregion

# ================ #
# INTERNAL UTILITY #
# ================ #
#region
func _on_visibility_changed() -> void: UI.set_visible(visible)

func change_view_state(new_state: ViewStates) -> void:
	if new_state == ViewStates.UN_CARD_PAIR_ME: new_state = ViewStates.COLLECTION if ViewState == ViewStates.COLLECTIONCARDPAIRS else ViewStates.DECKLIST if ViewState == ViewStates.DECKLISTCARDPAIRS else ViewStates.DECK if ViewState == ViewStates.DECKCARDPAIRS else ViewState
	ViewState = new_state
	match ViewState:
		ViewStates.COLLECTION, ViewStates.COLLECTIONCARDPAIRS:
			UI._show_deckdisplay(false)
			DisplayGrid._slide(false)
			WorkingDeck = null
		
		ViewStates.DECKLIST, ViewStates.DECKLISTCARDPAIRS:
			UI._show_deckdisplay(true)
			DisplayGrid._slide(true)
			WorkingDeck = null
		
		ViewStates.DECK, ViewStates.DECKCARDPAIRS:
			UI._show_deckdisplay(true)
			DisplayGrid._slide(true)

func create_exclusion_list() -> Array[Dictionary]:
	var card_array: Array[Dictionary] = []
	if WorkingDeck:
		card_array.append_array(WorkingDeck.Critters)
		card_array.append_array(WorkingDeck.Consumables)
		card_array.append_array(WorkingDeck.Weapons)
		card_array.append_array(WorkingDeck.WildCards)
	return card_array

func create_card_array() -> Array[Dictionary]:
	var cards : Array[Dictionary] = []
	var side: String = "DEF" if ShowingSecondary else "ATK"
	
	match SortingOrder:
		ContentCollection.SortOrders.EXPANSION:
			for expansion in DATA.ExpansionIDs:
				for type in DATA.ContentTypes:
					for rarity in DATA.Rarities:
						for content_ID in WorkingCollection.collection[expansion][side][rarity][type]:
							cards.append({
								Card.DictFields.EXPANSIONID  : DATA.ExpansionIDs[expansion],
								Card.DictFields.RARITY       : DATA.Rarities[rarity],
								Card.DictFields.TYPE         : DATA.ContentTypes[type],
								Card.DictFields.CONTENTINDEX : content_ID
							})
		ContentCollection.SortOrders.TYPE:
			for type in DATA.ContentTypes:
				for rarity in DATA.Rarities:
					for expansion in DATA.ExpansionIDs:
						for content_ID in WorkingCollection.collection[expansion][side][rarity][type]:
							cards.append({
								Card.DictFields.EXPANSIONID  : DATA.ExpansionIDs[expansion],
								Card.DictFields.RARITY       : DATA.Rarities[rarity],
								Card.DictFields.TYPE         : DATA.ContentTypes[type],
								Card.DictFields.CONTENTINDEX : content_ID
							})
		ContentCollection.SortOrders.RARITY:
			for rarity in DATA.Rarities:
				for type in DATA.ContentTypes:
					for expansion in DATA.ExpansionIDs:
						for content_ID in WorkingCollection.collection[expansion][side][rarity][type]:
							cards.append({
								Card.DictFields.EXPANSIONID  : DATA.ExpansionIDs[expansion],
								Card.DictFields.RARITY       : DATA.Rarities[rarity],
								Card.DictFields.TYPE         : DATA.ContentTypes[type],
								Card.DictFields.CONTENTINDEX : content_ID
							})
	
	return cards

func create_card_array_from_card(StartingCard: Card) -> Array[Dictionary]:
	var cards : Array[Dictionary] = []
	var side: String =  "DEF" if ShowingSecondary else "ATK"
	
	var expansion = DATA.ExpansionIDs.find_key(StartingCard.ExpansionID)
	var rarity = DATA.Rarities.find_key(StartingCard.Rarity)
	var type = DATA.ContentTypes.find_key(StartingCard.Type)
	var idx = StartingCard.ContentIndex

	for paired_rarity in DATA.Rarities:
		for paired_content_ID in WorkingCollection.collection[expansion][side][rarity][type][idx][paired_rarity]:
			cards.append({
				"FRONT" : {
					Card.DictFields.EXPANSIONID  : DATA.ExpansionIDs[expansion],
					Card.DictFields.RARITY       : DATA.Rarities[paired_rarity],
					Card.DictFields.TYPE         : DATA.ContentTypes[type],
					Card.DictFields.CONTENTINDEX : paired_content_ID
				},
				"BACK" : {
					Card.DictFields.EXPANSIONID  : DATA.ExpansionIDs[expansion],
					Card.DictFields.RARITY       : DATA.Rarities[rarity],
					Card.DictFields.CONTENTINDEX : idx
				}
			})
	
	return cards

#func _notification(what: int) -> void: if visible and what == NOTIFICATION_WM_GO_BACK_REQUEST: _on_ui_back_button_pressed()
#endregion
