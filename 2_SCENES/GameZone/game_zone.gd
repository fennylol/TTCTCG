extends Node3D
class_name GameZoneNode

signal finished

@onready var UI: GameUINode = $GameUI

func enter_game_zone()        -> void: 
	var decks: Dictionary = {}
	for deck_name in COLLECTION.decks:
		var deck_dict = COLLECTION.decks[deck_name]
		if Deck.dict_is_playable(deck_dict):
			decks[deck_dict[Deck.DictFields.NAME]]=deck_dict
	UI._passthrough_to_deckdisplay_show_decks(decks)
	
	
func _on_visibility_changed() -> void: UI.set_visible(visible)

# ================ #
# signal reception #
# ================ #
func _on_ui_back_button_pressed()                          -> void: finished.emit()
func _on_ui_passthrough_select_deck(deck: Deck)            -> void: _to_ui_passthrough_show_deck_content(deck) 
func _on_ui_passthrough_select_card(card_dict: Dictionary) -> void: 
	if PlayablePair.dict_is_playable_pair(card_dict):
		var pair := PlayablePair.restore_from_dict(card_dict)
		LOGGER.log_msg("GameZone.gd - _on_ui_passthrough_select_card(): " + pair.Name + " paired with " + pair.PairedName + " selected in GameZone.")
		pair.queue_free() 
# ============= #
# call emission #
# ============= #
func _to_ui_passthrough_show_deck_content(deck: Deck) -> void: UI._passthrough_to_deckdisplay_show_deck_content(deck)
# ================ #
# internal utility #
# ================ #
#func _notification(what: int) -> void: if visible and what == NOTIFICATION_WM_GO_BACK_REQUEST: finished.emit()
