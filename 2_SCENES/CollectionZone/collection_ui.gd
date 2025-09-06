extends Control

signal sorting_by (SortOrder: ContentCollection.SortOrders)
signal back_button_pressed
signal building_button_toggled (state: bool)
signal deck_selected(deck: Deck)
signal DEBUG_reset_button_pressed

@onready var CardsButton : Button = $VBoxContainer/TopBar/CardsButton
@onready var DecksButton : Button = $VBoxContainer/TopBar/DecksButton
@onready var DecksList : VBoxContainer = $VBoxContainer/CONTENT/DecksList
@onready var SortOrderMenuButton = $VBoxContainer/TopBar/SortOrderMenu
var SortOrderMenu
var PressedIcon = preload("res://1_ASSETS/UI/DEBUG_button_pressed.png")
var UnpressedIcon = preload("res://1_ASSETS/UI/DEBUG_button.png")

func _ready() -> void:
	SortOrderMenu = SortOrderMenuButton.get_popup()
	SortOrderMenu.index_pressed.connect(sorting_by.emit)

func recieve_deck_list(Decks : Array[Deck]) -> void:
	new_VBOX("DecksList")
	
	for deck in Decks:
		var icon = load("res://1_ASSETS/cards/art/0_Common/TEST_SET/Rat.png")
		var deck_button = new_deck_button(deck, icon)
		DecksList.add_child(deck_button)
	
	var new_deck_icon = load("res://1_ASSETS/cards/art/0_Common/TEST_SET/RegularCigarette.png")
	var deck_button = new_deck_button(Deck.new(), new_deck_icon)
	DecksList.add_child(deck_button)


func recieve_card(card: Card) -> void:
	if DecksList is DeckDisplay:
		DecksList.recieve_card(card)



# =============== #
# signal emission #
# =============== #
#region
func _on_back_button_pressed() -> void: 
	DecksList.visible = false
	DecksButton.icon = UnpressedIcon
	CardsButton.icon = PressedIcon
	back_button_pressed.emit()
func _on_reset_button_pressed() -> void: DEBUG_reset_button_pressed.emit()
func _on_check_button_toggled(toggled_on: bool) -> void: building_button_toggled.emit(toggled_on)
func _on_decks_button_pressed() -> void:
	DecksList.visible = true
	DecksButton.icon = PressedIcon
	CardsButton.icon = UnpressedIcon
	building_button_toggled.emit(true)
func _on_cards_button_pressed() -> void:
	DecksList.visible = false
	CardsButton.icon = PressedIcon
	DecksButton.icon = UnpressedIcon
	building_button_toggled.emit(false)
func _on_select_deck(deck: Deck) -> void:
	CardsButton.icon = UnpressedIcon
	DecksButton.icon = UnpressedIcon
	deck_selected.emit(deck)
	
	new_VBOX("Deck", true)
	DecksList.Save.connect(func(): print("saved decxk"))
	DecksList.Back.connect(_on_decks_button_pressed)
	DecksList.ChangeName.connect(func(name: String): print("deck is now: ", name))
#endregion

# ============= #
# node creation #
# ============= # 
#region
func new_VBOX(VBOX_name: String, deck: bool = false):
	var DLparent : Control = DecksList.get_parent()
	DLparent.remove_child(DecksList)
	DecksList.queue_free()
	
	DecksList = DeckDisplay.new() if deck else VBoxContainer.new() 
	DecksList.name = VBOX_name
	DecksList.size_flags_horizontal |= Control.SIZE_EXPAND
	DLparent.add_child(DecksList)

func new_deck_button(deck: Deck, icon: Texture2D) -> Button:
	var deck_button = Button.new()
	var select_deck = func(): _on_select_deck(deck)
	deck_button.pressed.connect(select_deck)
	deck_button.icon = icon
	return deck_button
#endregion
