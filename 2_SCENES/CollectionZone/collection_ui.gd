extends Control

signal sorting_by (SortOrder: ContentCollection.SortOrders)
signal showing_side (Defense: bool)
signal back_button_pressed
signal building_button_toggled (state: bool)
signal deck_selected(deck: Deck)

signal save_deck
signal delete_deck(deck)
signal deck_name_changed(new_name: String)
signal RemoveCard(card : PlayablePair)

signal DEBUG_reset_button_pressed

@onready var CardsButton : Button = $VBoxContainer/TopBar/CardsButton
@onready var DecksButton : Button = $VBoxContainer/TopBar/DecksButton
@onready var DecksList : VBoxContainer = $VBoxContainer/CONTENT/DecksList
@onready var ShowSideButton : MenuButton = $VBoxContainer/TopBar/ShowSideMenu
@onready var SortOrderMenuButton : MenuButton = $VBoxContainer/TopBar/SortOrderMenu
@onready var SortOrderMenu : PopupMenu = SortOrderMenuButton.get_popup()
@onready var ShowSideMenu : PopupMenu = ShowSideButton.get_popup()

const PRESSED_ICON = preload("res://1_ASSETS/UI/DEBUG_button_pressed.png")
const UNPRESSED_ICON = preload("res://1_ASSETS/UI/DEBUG_button.png")
const X_ICON = preload("res://1_ASSETS/UI/X.png")
const PLUS_ICON = preload("res://1_ASSETS/UI/+.png")

func _ready() -> void:
	SortOrderMenu.index_pressed.connect(sorting_by.emit)
	ShowSideMenu.index_pressed.connect(showing_side.emit)

func recieve_deck_list(Decks: Dictionary) -> void:
	new_VBOX("DecksList")
	
	for deck_name in Decks:
		var dict: Dictionary = Decks[deck_name]
		var deck := Deck.parse_single_deck(dict)
		var icon := deck.Critters[0].Img if deck.Critters.size() > 0 else \
					deck.Consumables[0].Img if deck.Consumables.size() > 0 else \
					deck.Weapons[0].Img if deck.Weapons.size() > 0 else X_ICON
		deck.Name = deck_name
		deck.LastSavedName = deck_name
		var deck_button = new_deck_button(deck, icon)
		DecksList.add_child(deck_button)
	
	var new_deck_icon = PLUS_ICON
	var deck_button = new_deck_button(Deck.new(), new_deck_icon, false)
	DecksList.add_child(deck_button)

func recieve_deck(deck: Deck) -> void:
	if DecksList is DeckDisplay:
		DecksList.recieve_deck(deck)

func recieve_card(card: Card) -> void:
	if DecksList is DeckDisplay:
		DecksList.recieve_card(card)



# =============== #
# signal emission #
# =============== #
#region
func _on_back_button_pressed() -> void: 
	DecksList.visible = false
	DecksButton.icon = UNPRESSED_ICON
	CardsButton.icon = PRESSED_ICON
	back_button_pressed.emit()
func _on_reset_button_pressed() -> void: DEBUG_reset_button_pressed.emit()
func _on_check_button_toggled(toggled_on: bool) -> void: building_button_toggled.emit(toggled_on)
func _on_decks_button_pressed() -> void:
	DecksList.visible = true
	DecksButton.icon = PRESSED_ICON
	CardsButton.icon = UNPRESSED_ICON
	building_button_toggled.emit(true)
func _on_cards_button_pressed() -> void:
	DecksList.visible = false
	CardsButton.icon = PRESSED_ICON
	DecksButton.icon = UNPRESSED_ICON
	building_button_toggled.emit(false)
func _on_select_deck(deck: Deck) -> void:
	CardsButton.icon = UNPRESSED_ICON
	DecksButton.icon = UNPRESSED_ICON
	
	new_VBOX("Deck", true)
	DecksList.Back.connect(_on_decks_button_pressed)
	DecksList.Save.connect(save_deck.emit)
	DecksList.ChangeName.connect(deck_name_changed.emit)
	DecksList.RemoveCard.connect(RemoveCard.emit)
	
	deck_selected.emit(deck)
func _on_delete_deck(deck: Deck) -> void:
	delete_deck.emit(deck)
	_on_decks_button_pressed()
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

func new_deck_button(deck: Deck, icon: Texture2D, AddDeleteButton: bool = true) -> HBoxContainer:
	var cntl := HBoxContainer.new()
	cntl.name = deck.Name.replace(" ", "_").to_lower() + "_list"
	
	var deck_button := TextureButton.new()
	deck_button.name = "edit_" + deck.Name.replace(" ", "_").to_lower() + "_button"
	deck_button.texture_normal = icon
	deck_button.size_flags_horizontal |= Control.SIZE_EXPAND
	deck_button.pressed.connect(func(): _on_select_deck(deck))
	cntl.add_child(deck_button)
	
	var deck_label := Label.new()
	deck_label.name = deck.Name.replace(" ", "_").to_lower() + "_label"
	deck_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	deck_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	deck_label.set_anchors_preset(Control.PRESET_FULL_RECT)
	deck_label.text = deck.Name + ("   " if AddDeleteButton else "            ")
	deck_button.add_child(deck_label)
	
	if AddDeleteButton:
		var delete_button := TextureButton.new()
		delete_button.name = "delete_" + deck.Name.replace(" ", "_").to_lower() + "_button"
		delete_button.texture_normal = X_ICON
		delete_button.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		delete_button.pressed.connect(func(): _on_delete_deck(deck))
		cntl.add_child(delete_button)
	
	return cntl
#endregion
