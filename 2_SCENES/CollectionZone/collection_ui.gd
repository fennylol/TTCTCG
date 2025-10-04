extends Control
class_name CollectionUIUpdated

signal DEBUG_reset_button_pressed
signal back_button_pressed
signal show_collection_button_pressed
signal show_decks_button_pressed
signal sort_order_selected(sort_order: ContentCollection.SortOrders)
signal show_side_selected(show_secondary: bool)

signal passthrough_select_deck(deck: Deck)
signal passthrough_save_deck 
signal passthrough_rename_deck 
signal passthrough_delete_deck(deck: Deck)
signal passthrough_remove_card_from_deck

@onready var ShowCollectionButton : Button = $VBoxContainer/TopBar/ShowCollectionButton
@onready var ShowDecksButton : Button = $VBoxContainer/TopBar/ShowDecksButton
@onready var DeckDisplaySidebar : DeckDisplay2 = $VBoxContainer/CONTENT/DeckDisplay
@onready var ShowSideButton : MenuButton = $VBoxContainer/TopBar/ShowSideMenu
@onready var SortOrderMenuButton : MenuButton = $VBoxContainer/TopBar/SortOrderMenu
@onready var SortOrderMenu : PopupMenu = SortOrderMenuButton.get_popup()
@onready var ShowSideMenu : PopupMenu = ShowSideButton.get_popup()

const PRESSED_ICON = preload("res://1_ASSETS/UI/DEBUG_button_pressed.png")
const UNPRESSED_ICON = preload("res://1_ASSETS/UI/DEBUG_button.png")

func _ready() -> void: connect_on_sort_collection()
# =============== #
# signal emission #
# =============== #
func connect_on_sort_collection()         -> void: SortOrderMenu.index_pressed.connect(sort_order_selected.emit); ShowSideMenu.index_pressed.connect(show_side_selected.emit)
func _on_back_button_pressed()            -> void: back_button_pressed.emit()
func _on_show_collection_button_pressed() -> void: show_collection_button_pressed.emit()
func _on_show_decks_button_pressed()      -> void: show_decks_button_pressed.emit()
func _on_DEBUG_reset_button_pressed()     -> void: DEBUG_reset_button_pressed.emit()
# ================== #
# signal propegation #
# ================== #
func _on_deckdisplay_finished()                                -> void: back_button_pressed.emit()
func _on_deckdisplay_select_deck(deck: Deck)                   -> void: passthrough_select_deck.emit(deck)
func _on_deckdisplay_save_deck()                               -> void: passthrough_save_deck.emit()
func _on_deckdisplay_rename_deck(new_name: String)             -> void: passthrough_rename_deck.emit(new_name)
func _on_deckdisplay_delete_deck()                             -> void: passthrough_delete_deck.emit()
func _on_deckdisplay_remove_card_from_deck(card: PlayablePair) -> void: passthrough_remove_card_from_deck.emit(card)
# ============== #
# call reception #
# ============== #
func _show_collection() -> void:
	ShowCollectionButton.icon = PRESSED_ICON
	ShowDecksButton.icon = UNPRESSED_ICON
	DeckDisplaySidebar.visible = false
# ================ #
# call propegation #
# ================ #
func _passthrough_to_deckdisplay_show_decks(deck_list: Dictionary) -> void:
	ShowCollectionButton.icon = UNPRESSED_ICON
	ShowDecksButton.icon = PRESSED_ICON
	DeckDisplaySidebar.visible = true
	DeckDisplaySidebar._show_decks(deck_list)
func _passthrough_to_deckdisplay_show_deck_content(deck: Deck) -> void:
	ShowCollectionButton.icon = UNPRESSED_ICON
	ShowDecksButton.icon = PRESSED_ICON
	DeckDisplaySidebar.visible = true
	DeckDisplaySidebar._show_deck_content(deck)
func _passthrough_to_deckdisplay_add_card_to_deck(card: Card) -> void:
	DeckDisplaySidebar._add_card_to_deck(card)
