extends Node3D

signal finished

@onready var UI = $GameUI

func enter_game_zone(decks: Dictionary) -> void: UI._passthrough_to_deckdisplay_show_decks(decks)
func _on_visibility_changed()           -> void: UI.set_visible(visible)

# ================ #
# signal reception #
# ================ #
func _on_ui_back_button_pressed()                                 -> void: finished.emit()
func _on_ui_passthrough_remove_card_from_deck(card: PlayablePair) -> void: print(card.Name) 
func _on_ui_passthrough_select_deck(deck: Deck)                   -> void: _to_ui_passthrough_show_deck_content(deck) 
# ============= #
# call emission #
# ============= #
func _to_ui_passthrough_show_deck_content(deck: Deck) -> void: UI._passthrough_to_deckdisplay_show_deck_content(deck)
