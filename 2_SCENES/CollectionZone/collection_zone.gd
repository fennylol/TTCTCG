extends Node3D
class_name CollectionZoneNode

signal finished

@onready var DisplayGrid: ContentGrid = $ContentGrid
@onready var DisplayZone: Node3D = $DisplayZone
@onready var UI: CollectionUINode = $CollectionUI
enum ViewStates {COLLECTION, COLLECTIONCARDPAIRS, COLLECTIONCARDDISPLAY, DECKLIST, DECKLISTCARDPAIRS, DECKLISTCARDDISPLAY, DECK, DECKCARDPAIRS, UN_CARD_PAIR_ME = -1}
var ViewState: ViewStates = ViewStates.COLLECTION
var WorkingDeck: Deck
var WorkingCard: Card

const LOWERED_DISPLAY: float = -0.75

var SortingOrder := ContentCollection.SortOrders.EXPANSION
var ShowingSecondary: bool = false

func _ready() -> void:
	#return
	var load_err: Error = COLLECTION._load()
	if load_err == OK:
		_to_display_grid_send_card_list()
	else: 
		LOGGER.log_msg("collection_zone.gd: collection failed to load: " + str(load_err), LOGGER.Flags.ERR_STDOUT)

func enter_collection_zone():
	change_view_state(ViewStates.COLLECTION)
	_to_ui_show_collection()
	_to_display_grid_send_card_list()

# ============== #
# user interface #
# ============== #
#region
func _on_ui_DEBUG_reset_button_pressed() -> void: 
	COLLECTION.DEBUG_reset()
	enter_collection_zone()
# signal reception
func _on_ui_back_button_pressed() -> void: 
	match ViewState:
		ViewStates.COLLECTION: 
			change_view_state(ViewStates.COLLECTION)
			finished.emit()
		ViewStates.COLLECTIONCARDPAIRS:
			change_view_state(ViewStates.COLLECTION)
			_to_ui_show_collection()
			_to_display_grid_send_card_list()
		ViewStates.COLLECTIONCARDDISPLAY:
			_to_display_grid_send_card_list_from_card(WorkingCard)
			change_view_state(ViewStates.COLLECTIONCARDPAIRS)
			empty_display_zone()
			_to_ui_show_collection()
		
		ViewStates.DECKLIST:
			change_view_state(ViewStates.COLLECTION)
			_to_ui_show_collection()
		ViewStates.DECKLISTCARDPAIRS:
			change_view_state(ViewStates.DECKLIST)
			_to_ui_passthrough_show_decks()
			_to_display_grid_send_card_list()
		ViewStates.DECKLISTCARDDISPLAY:
			_to_display_grid_send_card_list_from_card(WorkingCard)
			change_view_state(ViewStates.DECKLISTCARDPAIRS)
			empty_display_zone()
			_to_ui_passthrough_show_decks()
		
		ViewStates.DECK:
			change_view_state(ViewStates.DECKLIST)
			WorkingDeck = null
			_to_ui_passthrough_show_decks()
			_to_display_grid_send_exclusions()  
		ViewStates.DECKCARDPAIRS:
			change_view_state(ViewStates.DECK)
			_to_display_grid_send_card_list()
			_to_display_grid_send_exclusions()  
func _on_ui_show_decks_button_pressed() -> void: 
	var new_state: ViewStates = ViewStates.DECKLIST
	if   ViewState == ViewStates.COLLECTIONCARDPAIRS or \
		 ViewState == ViewStates.DECKLISTCARDPAIRS   or \
		 ViewState == ViewStates.DECKCARDPAIRS:
		new_state = ViewStates.DECKLISTCARDPAIRS
	elif ViewState == ViewStates.COLLECTIONCARDDISPLAY or \
		 ViewState == ViewStates.DECKLISTCARDDISPLAY:
		new_state = ViewStates.DECKLISTCARDDISPLAY
	change_view_state(new_state)
	_to_ui_passthrough_show_decks() 
	_to_display_grid_send_card_list(DisplayGrid.ContentList)

func _on_ui_show_collection_button_pressed() -> void: 
	var new_state: ViewStates = ViewStates.COLLECTION
	if   ViewState == ViewStates.COLLECTIONCARDPAIRS or \
		 ViewState == ViewStates.DECKLISTCARDPAIRS   or \
		 ViewState == ViewStates.DECKCARDPAIRS:
		new_state = ViewStates.COLLECTIONCARDPAIRS
	elif ViewState == ViewStates.COLLECTIONCARDDISPLAY or \
		 ViewState == ViewStates.DECKLISTCARDDISPLAY:
		new_state = ViewStates.COLLECTIONCARDDISPLAY
	change_view_state(new_state)     
	_to_ui_show_collection()         
	_to_display_grid_send_card_list(DisplayGrid.ContentList)

func _on_ui_sort_order_selected(sort_order: ContentCollection.SortOrders) -> void: 
	change_view_state(ViewStates.UN_CARD_PAIR_ME)
	SortingOrder = sort_order        
	_to_display_grid_send_card_list()

func _on_ui_show_side_selected(show_secondary: bool) -> void: 
	change_view_state(ViewStates.UN_CARD_PAIR_ME)
	ShowingSecondary = show_secondary
	_to_display_grid_send_card_list()
func _on_ui_passthrough_select_deck(deck: Deck) -> void: 
	var new_state: ViewStates = ViewStates.DECK
	if   ViewState == ViewStates.COLLECTIONCARDPAIRS or \
		 ViewState == ViewStates.DECKLISTCARDPAIRS   or \
		 ViewState == ViewStates.DECKCARDPAIRS:
		new_state = ViewStates.DECKCARDPAIRS
	change_view_state(new_state)
	WorkingDeck = deck
	_to_display_grid_send_card_list(DisplayGrid.ContentList if DisplayGrid.ContentList else create_card_dict_array())
	_to_ui_passthrough_show_deck_content(deck)
func _on_ui_passthrough_save_deck()                   -> void: _to_content_collection_save_deck()
func _on_ui_passthrough_rename_deck(new_name: String) -> void: _to_content_collection_rename_deck(new_name)
func _on_ui_passthrough_delete_deck(deck: Deck)       -> void: _to_content_collection_delete_deck(deck)
func _on_ui_passthrough_select_card(card: Dictionary) -> void: _to_ui_remove_card_from_deck(card)
# call emission
func _to_ui_show_collection()                              -> void: UI._show_collection()
func _to_ui_passthrough_show_decks()                       -> void: UI._passthrough_to_deckdisplay_show_decks(COLLECTION.decks)
func _to_ui_passthrough_show_deck_content(deck: Deck)      -> void: UI._passthrough_to_deckdisplay_show_deck_content(deck)
func _to_ui_passthrough_add_card_to_deck(card: Dictionary) -> void: UI._passthrough_to_deckdisplay_add_card_to_deck(card)
func _to_ui_remove_card_from_deck(card: Dictionary)        -> void: 
	WorkingDeck.remove_from_deck(card)
	UI._passthrough_to_deckdisplay_remove_card_from_deck(card)
	_to_display_grid_send_exclusions()
#endregion

# ============ #
# display grid #
# ============ #
#region
# signal reception
func _on_display_grid_card_clicked(card: Card, _content_holder: ContentHolder) -> void: 
	#var card_spin = func(next_view_state: ViewStates):
		#if card.position.y == 0:
			#var old_pos = content_holder.position.y
			#var return_to_zero = func(_string): 
				#card.position.y = 0
				#content_holder.position.y = old_pos
				#change_view_state(next_view_state)
				#_to_display_grid_send_card_list()
			#card.play_anim("moves/PairSpin")
			#content_holder.position.y -= 4.5
			#if !card.AnimationComplete.is_connected(return_to_zero):
				#card.AnimationComplete.connect(return_to_zero)
	var display_card = func(card_to_display: Card) -> void:
		WorkingCard = PlayablePair.restore_from_dict((card_to_display as PlayablePair).reduce_to_dict(true)) if card_to_display is PlayablePair else card_to_display
		DisplayZone.add_child(DisplayCase.new(WorkingCard))
		_to_display_grid_send_card_list([])
	
	match ViewState:
		ViewStates.COLLECTION:
			LOGGER.log_msg("collection_zone.gd - _on_display_grid_card_clicked(): " + card.Name + " clicked in COLLECTION",          LOGGER.Flags.MSG_STDOUT)
			change_view_state(ViewStates.COLLECTIONCARDPAIRS)
			_to_display_grid_send_card_list_from_card(card)
		ViewStates.COLLECTIONCARDPAIRS:
			LOGGER.log_msg("collection_zone.gd - _on_display_grid_card_clicked(): " + card.Name + " clicked in COLLECTIONCARDPAIRS", LOGGER.Flags.MSG_STDOUT)
			change_view_state(ViewStates.COLLECTIONCARDDISPLAY)
			display_card.call(card)
		
		ViewStates.DECKLIST:
			LOGGER.log_msg("collection_zone.gd - _on_display_grid_card_clicked(): " + card.Name + " clicked in DECKLIST",            LOGGER.Flags.MSG_STDOUT)
			change_view_state(ViewStates.DECKLISTCARDPAIRS)
			_to_display_grid_send_card_list_from_card(card)
		ViewStates.DECKLISTCARDPAIRS:
			LOGGER.log_msg("collection_zone.gd - _on_display_grid_card_clicked(): " + card.Name + " clicked in DECKLISTCARDPAIRS",    LOGGER.Flags.MSG_STDOUT)
			change_view_state(ViewStates.DECKLISTCARDDISPLAY)
			display_card.call(card)
		
		ViewStates.DECK:
			LOGGER.log_msg("collection_zone.gd - _on_display_grid_card_clicked(): " + card.Name + " clicked in DECK",                 LOGGER.Flags.MSG_STDOUT)
			change_view_state(ViewStates.DECKCARDPAIRS)
			_to_display_grid_send_card_list_from_card(card)
		ViewStates.DECKCARDPAIRS:
			LOGGER.log_msg("collection_zone.gd - _on_display_grid_card_clicked(): " + card.Name + " clicked in DECKCARDPAIRS",        LOGGER.Flags.MSG_STDOUT)
			assert(card is PlayablePair, "Clicked card is not PlayablePair")
			var card_dict = (card as PlayablePair).reduce_to_dict() if ShowingSecondary else (card as PlayablePair).reduce_to_dict(true)
			WorkingDeck.add_to_deck(card_dict)
			_to_ui_passthrough_add_card_to_deck(card_dict)
			_to_display_grid_send_card_list()
			change_view_state(ViewStates.DECK)
# call emission
func _to_display_grid_send_card_list(cards: Array[Dictionary] = create_card_dict_array()) -> void: DisplayGrid._recieve_content_list(cards)  ; _to_display_grid_send_exclusions() ;
func _to_display_grid_send_card_list_from_card(card: Card)     -> void: DisplayGrid._recieve_content_list(create_card_array_from_card(card)) ; _to_display_grid_send_exclusions() ;
func _to_display_grid_send_exclusions()                        -> void: DisplayGrid._recieve_exclusion_list(create_exclusion_list())
#endregion

# ================== #
# content collection #
# ================== #
#region
# call emission
func _to_content_collection_recieve_cards(ExpansionID : DATA.ExpansionIDs,
										  CardList : Array[Card]) -> void: COLLECTION._recieve_cards(ExpansionID, CardList)
func _to_content_collection_save_deck()                           -> void: COLLECTION._recieve_deck(WorkingDeck)
func _to_content_collection_delete_deck(deck: Deck)               -> void: COLLECTION._delete_deck(deck.Name) ; if deck != WorkingDeck: _to_ui_passthrough_show_decks()
func _to_content_collection_rename_deck(new_name: String)         -> void: 
	_to_content_collection_delete_deck(WorkingDeck)
	WorkingDeck.Name = new_name
	_to_content_collection_save_deck()
#endregion

# ================ #
# internal utility #
# ================ #
#region
func _on_visibility_changed() -> void: UI.set_visible(visible)

func change_view_state(new_state: ViewStates) -> void:
	if !(new_state == ViewStates.COLLECTIONCARDDISPLAY or \
		 new_state == ViewStates.DECKLISTCARDDISPLAY):
		empty_display_zone()
	
	if new_state == ViewStates.UN_CARD_PAIR_ME: 
		new_state = ViewStates.COLLECTION               if ViewState == ViewStates.COLLECTIONCARDPAIRS   \
					else ViewStates.COLLECTIONCARDPAIRS if ViewState == ViewStates.COLLECTIONCARDDISPLAY \
					else ViewStates.DECKLIST            if ViewState == ViewStates.DECKLISTCARDPAIRS     \
					else ViewStates.DECKLISTCARDPAIRS   if ViewState == ViewStates.DECKLISTCARDDISPLAY   \
					else ViewStates.DECK                if ViewState == ViewStates.DECKCARDPAIRS         \
					else ViewState
	ViewState = new_state
	match ViewState:
		ViewStates.COLLECTION, ViewStates.COLLECTIONCARDPAIRS, ViewStates.COLLECTIONCARDDISPLAY:
			UI._show_deckdisplay(false)
			DisplayGrid._modify_scroll(false)
			DisplayZone.position.y = 0
			WorkingDeck = null
		
		ViewStates.DECKLIST, ViewStates.DECKLISTCARDPAIRS, ViewStates.DECKLISTCARDDISPLAY:
			UI._show_deckdisplay(true)
			DisplayGrid._modify_scroll(true)
			DisplayZone.position.y = LOWERED_DISPLAY
			WorkingDeck = null
		
		ViewStates.DECK, ViewStates.DECKCARDPAIRS:
			UI._show_deckdisplay(true)
			DisplayGrid._modify_scroll(true)
			DisplayZone.position.y = LOWERED_DISPLAY

func create_exclusion_list() -> Array[Dictionary]:
	var card_array: Array[Dictionary] = []
	if WorkingDeck:
		card_array.append_array(WorkingDeck.Critters)
		card_array.append_array(WorkingDeck.Consumables)
		card_array.append_array(WorkingDeck.Weapons)
		card_array.append_array(WorkingDeck.WildCards)
	return card_array

func create_card_dict_array() -> Array[Dictionary]:
	var cards : Array[Dictionary] = []
	var side = DATA.ContentSides.find_key(DATA.ContentSides.BAKER) if ShowingSecondary else DATA.ContentSides.find_key(DATA.ContentSides.TAKER)
	
	match SortingOrder:
		ContentCollection.SortOrders.EXPANSION:
			for expansion in DATA.ExpansionIDs:
				for type in DATA.ContentTypes:
					for rarity in DATA.Rarities:
						for content_ID in COLLECTION.collection[expansion][side][rarity][type]:
							#var count: int = 0
							#for paired_rarity in COLLECTION.collection[expansion][side][rarity][type][content_ID]:
								#for paired_ID in COLLECTION.collection[expansion][side][rarity][type][content_ID][paired_rarity]:
									#count += COLLECTION.collection[expansion][side][rarity][type][content_ID][paired_rarity][paired_ID]
							#
							#cards.append({
								#"COUNT" : count,
								#"CARD"  : {
									#Card.DictFields.EXPANSIONID  : DATA.ExpansionIDs[expansion],
									#Card.DictFields.RARITY       : DATA.Rarities[rarity],
									#Card.DictFields.TYPE         : DATA.ContentTypes[type],
									#Card.DictFields.CONTENTINDEX : content_ID
								#}
							#})
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
						for content_ID in COLLECTION.collection[expansion][side][rarity][type]:
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
						for content_ID in COLLECTION.collection[expansion][side][rarity][type]:
							cards.append({
								Card.DictFields.EXPANSIONID  : DATA.ExpansionIDs[expansion],
								Card.DictFields.RARITY       : DATA.Rarities[rarity],
								Card.DictFields.TYPE         : DATA.ContentTypes[type],
								Card.DictFields.CONTENTINDEX : content_ID
							})
	
	return cards

func create_card_array_from_card(StartingCard: Card) -> Array[Dictionary]:
	var cards : Array[Dictionary] = []
	var side = DATA.ContentSides.find_key(DATA.ContentSides.BAKER) if ShowingSecondary else DATA.ContentSides.find_key(DATA.ContentSides.TAKER)
	
	var expansion = DATA.ExpansionIDs.find_key(StartingCard.ExpansionID)
	var rarity = DATA.Rarities.find_key(StartingCard.Rarity)
	var type = DATA.ContentTypes.find_key(StartingCard.Type)
	var idx = StartingCard.ContentIndex

	for paired_rarity in DATA.Rarities:
		for paired_content_ID in COLLECTION.collection[expansion][side][rarity][type][idx][paired_rarity]:
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

func empty_display_zone() -> void:
	if WorkingCard: WorkingCard = null
	while DisplayZone.get_child_count() > 0: 
		var child = DisplayZone.get_child(0)
		DisplayZone.remove_child(child)
		if child != WorkingCard: child.queue_free()
#func _notification(what: int) -> void: if visible and what == NOTIFICATION_WM_GO_BACK_REQUEST: _on_ui_back_button_pressed()
#endregion
