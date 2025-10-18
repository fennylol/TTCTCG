extends Control
class_name GameUINode

signal back_button_pressed
signal passthrough_select_deck(deck: Deck)
signal passthrough_slect_card(card: PlayablePair)

@onready var DeckDisplaySidebar : DeckDisplay = $VBoxContainer/Body/BodyPanelPadding/BodyPanelContainer/DeckDisplayPadding/DeckDisplay

func _ready() -> void: DeckDisplaySidebar.Editable = false
# =============== #
# signal emission #
# =============== #
func _on_back_button_pressed() -> void: back_button_pressed.emit()
# ================== #
# signal propegation #
# ================== #
func _on_deckdisplay_finished()                      -> void: back_button_pressed.emit()
func _on_deckdisplay_select_deck(deck: Deck)         -> void: passthrough_select_deck.emit(deck)
func _on_deckdisplay_select_card(card: PlayablePair) -> void: passthrough_slect_card.emit(card)
# ================ #
# call propegation #
# ================ #
func _passthrough_to_deckdisplay_show_decks(decks: Dictionary) -> void: DeckDisplaySidebar._show_decks(decks)
func _passthrough_to_deckdisplay_show_deck_content(deck: Deck) -> void: DeckDisplaySidebar._show_deck_content(deck)
