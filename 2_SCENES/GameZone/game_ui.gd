extends Control

signal back_button_pressed
signal passthrough_select_deck(deck: Deck)
signal passthrough_remove_card_from_deck()

@onready var DeckDisplaySidebar : DeckDisplay = $VBoxContainer/CONTENT/DeckDisplay

func _ready()                                                  -> void: DeckDisplaySidebar.Editable = false
# =============== #
# signal emission #
# =============== #
func _on_back_button_pressed()                                 -> void: back_button_pressed.emit()
# ================== #
# signal propegation #
# ================== #
func _on_deckdisplay_finished()                                -> void: back_button_pressed.emit()
func _on_deckdisplay_select_deck(deck: Deck)                   -> void: passthrough_select_deck.emit(deck)
func _on_deckdisplay_remove_card_from_deck(card: PlayablePair) -> void: passthrough_remove_card_from_deck.emit(card)
# ================ #
# call propegation #
# ================ #
func _passthrough_to_deckdisplay_show_decks(decks: Dictionary) -> void: DeckDisplaySidebar._show_decks(decks)
func _passthrough_to_deckdisplay_show_deck_content(deck: Deck) -> void: DeckDisplaySidebar._show_deck_content(deck)
