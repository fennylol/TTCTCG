extends Node3D
class_name ContentGrid

signal card_clicked(card: Card, content_holder: ContentHolder)

const SPACING_WIDTH: float = 0.25
const SPACING_HEIGHT: float = 0.25
const SCROLL_TARGET_SPEED: float = 0.5
const SCROLL_SPEED: float = 5

var DisplayedCount: int = 0
var DisplayedWidth: int = 3

var ScrollTarget: float = 0.0
var SlideTarget: float = 0.0
var UNSLIDE_TARGET: float = 0.0
const SLIDE_TARGET: float = -5.0

var ContentList: Array[Card]
var ExclusionList: Array[Card]

func _init(): 
	UNSLIDE_TARGET = -(DisplayedWidth-1)/2.0 * (Card.CARD_WIDTH+SPACING_WIDTH)
	position.x = UNSLIDE_TARGET
	SlideTarget = UNSLIDE_TARGET

# ============== #
# CALL RECEPTION #
# ============== #
func _recieve_card_list(DisplayedContent: Array[Card]) -> void:
	ContentList = DisplayedContent
	display_content_list()
func _recieve_exclusion_list(ExcludedContent: Array[Card]) -> void:
	ExclusionList = ExcludedContent
	display_content_list()
func _recieve_displayed_width(RowWidth : int) -> void: 
	DisplayedWidth = RowWidth
	UNSLIDE_TARGET = -(DisplayedWidth-1)/2.0 * (Card.CARD_WIDTH+SPACING_WIDTH)
	display_content_list()

# ================ #
# INTERNAL UTILITY #
# ================ #
func display_content_list() -> void:
	DisplayedCount = 0
	kill_the_child()
	
	for card in ContentList:
		var card_copy = PlayablePair.create_from_playable_pair(card) if card is PlayablePair else Card.create_from_card(card)
		var ch: ContentHolder = display_content(card_copy)
		
		var excluded: bool = false
		for excluded_card in ExclusionList:
			excluded = excluded or (                                                           card.Name       == excluded_card.Name      )
			excluded = excluded or (card is PlayablePair and                                   card.PairedName == excluded_card.Name      )
			excluded = excluded or (                         excluded_card is PlayablePair and card.Name       == excluded_card.PairedName)
			excluded = excluded or (card is PlayablePair and excluded_card is PlayablePair and card.PairedName == excluded_card.PairedName)
		
		if excluded: card_copy._disable()
		else: ch.clicked.connect(func(): card_clicked.emit(card_copy, ch))
		add_child(ch)
		DisplayedCount += 1

func display_content(card: Card) -> ContentHolder:
	var plain_name: String = card.name.replace(" ", "_").to_lower()
	
	var content_holder := ContentHolder.new(plain_name)
	content_holder.add_child(card)

	var pos := Vector3(0,0,0)
	pos.x = (DisplayedCount%DisplayedWidth)*(Card.CARD_WIDTH+SPACING_WIDTH)
	pos.y = -(DisplayedCount/DisplayedWidth)*(Card.CARD_HEIGHT+SPACING_HEIGHT)
	content_holder.position = pos
	
	return content_holder

func kill_the_child() -> void: 
	for i in range(get_child_count()): 
		var node = get_child(0)
		remove_child(node)
		node.queue_free()

# ============== #
# INPUT HANDLING #
# ============== #
func _process(delta: float) -> void:
	if visible:
		var scroll: float = Input.get_axis("Up", "Down")
		if !scroll: scroll = (float(Input.is_action_just_released("Down"))-float(Input.is_action_just_released("Up")))
		ScrollTarget += scroll*SCROLL_TARGET_SPEED
		
		var row_count: int = floor(DisplayedCount/DisplayedWidth)
		var row_height: float = (Card.CARD_HEIGHT+SPACING_HEIGHT)
		ScrollTarget = max(min(ScrollTarget, (row_count*row_height)-SPACING_HEIGHT), 0)
		
		position.y = lerpf(position.y, ScrollTarget, delta*SCROLL_SPEED)
		position.x = lerpf(position.x, SlideTarget, delta*SCROLL_SPEED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_action_pressed("Next") and visible:
		if abs(event.relative.y): 
			var amount = -event.relative.y * get_process_delta_time()
			ScrollTarget += amount
