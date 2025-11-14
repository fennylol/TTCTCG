extends Node3D
class_name ContentGrid

signal card_clicked(card: Card, content_holder: ContentHolder)

const SPACING_WIDTH: float = 0.25
const SPACING_HEIGHT: float = 0.25
const SCROLL_TARGET_SPEED: float = 0.5
const SCROLL_SPEED: float = 5

var DisplayedCount: int = 0
var DisplayedWidth: int = 3

var ScrollTarget:  float = 0.0
var MinimumScroll: float = 0.0
var MaximumScroll: float = 0.0

var UNSCROLL_MODIFIER: float = 0.0
var SCROLL_MODIFIER:   float = -2.5

var ContentList: Array[Dictionary]
var ExclusionList: Array[Dictionary]


func _init(): 
	position.x = -(DisplayedWidth-1)/2.0 * (Card.CARD_WIDTH+SPACING_WIDTH)
	MinimumScroll = UNSCROLL_MODIFIER

# ============== #
# call reception #
# ============== #
func _modify_scroll(add_modifier: bool) -> void: 
	MinimumScroll = SCROLL_MODIFIER if add_modifier else UNSCROLL_MODIFIER
func _recieve_content_list(DisplayedContent: Array[Dictionary]) -> void:
	if ContentList.size() != DisplayedContent.size(): 
		ScrollTarget = MinimumScroll
		position.y = MinimumScroll
	ContentList = DisplayedContent
	set_maximum_scroll()
	display_content_list()
func _recieve_exclusion_list(ExcludedContent: Array[Dictionary]) -> void:
	ExclusionList = ExcludedContent
	display_content_list()
func _recieve_displayed_width(RowWidth : int) -> void: 
	DisplayedWidth = RowWidth
	position.x = -(DisplayedWidth-1)/2.0 * (Card.CARD_WIDTH+SPACING_WIDTH)
	set_maximum_scroll()
	display_content_list()
func set_maximum_scroll() -> void:
	var row_count: int = floor(ContentList.size()/DisplayedWidth)
	var row_height: float = Card.CARD_HEIGHT+SPACING_HEIGHT
	MaximumScroll = (row_count*row_height)-SPACING_HEIGHT
# ================ #
# internal utility #
# ================ #
func display_content_list() -> void:
	DisplayedCount = 0
	kill_the_children()
	
	var excludes : Array[Card]
	for excluded_dict in ExclusionList:
		if PlayablePair.dict_is_playable_pair(excluded_dict): excludes.append(PlayablePair.restore_from_dict(excluded_dict))
		elif Card.dict_is_card(excluded_dict): excludes.append(Card.restore_from_dict(excluded_dict))
		else: LOGGER.log_msg("content_grid.gd - display_content_list(): excluded_dict is not a Card or PlayablePair.", LOGGER.Flags.ERR)
	
	for card_dict in ContentList:
	#for info_dict in ContentList:
		#if not info_dict.keys().has("COUNT"): pass
		#if not info_dict.keys().has("CARD"): pass
		#
		#var count: int = info_dict["COUNT"]
		#var card_dict: Dictionary = info_dict["CARD"]
		var card : Card
		if PlayablePair.dict_is_playable_pair(card_dict): card = PlayablePair.restore_from_dict(card_dict)
		elif Card.dict_is_card(card_dict): card = Card.restore_from_dict(card_dict)
		else: LOGGER.log_msg("content_grid.gd - display_content_list(): card_dict is not a Card or PlayablePair.", LOGGER.Flags.ERR)
		
		var excluded: bool = false
		for excluded_card in excludes:
			excluded = excluded or (                                                           (card.Name       == excluded_card.Name       and card.ExpansionID       == excluded_card.ExpansionID      ))
			excluded = excluded or (card is PlayablePair and                                   (card.PairedName == excluded_card.Name       and card.PairedExpansionID == excluded_card.ExpansionID      ))
			excluded = excluded or (                         excluded_card is PlayablePair and (card.Name       == excluded_card.PairedName and card.ExpansionID       == excluded_card.PairedExpansionID))
			excluded = excluded or (card is PlayablePair and excluded_card is PlayablePair and (card.PairedName == excluded_card.PairedName and card.PairedExpansionID == excluded_card.PairedExpansionID))
		
		var ch: ContentHolder = display_content(card)
		if excluded: card._disable()
		else: ch.clicked.connect(func(): card_clicked.emit(card, ch))
		add_child(ch)
		DisplayedCount += 1
	
	for excluded_card in excludes: excluded_card.queue_free()

func display_content(card: Card, _count: int = 1) -> ContentHolder:
	var plain_name: String = card.name.replace(" ", "_").to_lower()
	
	var content_holder := ContentHolder.new(plain_name)
	content_holder.add_child(card)
	
	var pos := Vector3(0,0,0)
	pos.x = (DisplayedCount%DisplayedWidth)*(Card.CARD_WIDTH+SPACING_WIDTH)
	pos.y = -(DisplayedCount/DisplayedWidth)*(Card.CARD_HEIGHT+SPACING_HEIGHT)
	content_holder.position = pos
	
	return content_holder

func kill_the_children() -> void: 
	for i in range(get_child_count()): 
		var node = get_child(0)
		remove_child(node)
		node.queue_free()

# ============== #
# input handling #
# ============== #
func _process(delta: float) -> void:
	if is_visible_in_tree():
		position.y = lerpf(position.y, ScrollTarget, delta*SCROLL_SPEED)
		
		var scroll: float = Input.get_axis("Up", "Down")
		if !scroll: scroll = (float(Input.is_action_just_released("Down"))-float(Input.is_action_just_released("Up")))
		ScrollTarget += scroll*SCROLL_TARGET_SPEED
		
		if ScrollTarget < MinimumScroll:
			ScrollTarget = lerpf(ScrollTarget, MinimumScroll, delta*SCROLL_SPEED*(MinimumScroll-ScrollTarget))
		if ScrollTarget > MaximumScroll:
			ScrollTarget = lerpf(ScrollTarget, MaximumScroll, delta*SCROLL_SPEED*(ScrollTarget-MaximumScroll))
		#var capped_scroll_target = max(min(ScrollTarget-SlideTarget, (row_count*row_height)-SPACING_HEIGHT), SlideTarget)+SlideTarget
		
		#ScrollTarget = lerpf(ScrollTarget, capped_scroll_target, delta*SCROLL_SPEED*absf(ScrollTarget-capped_scroll_target))



func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag and is_visible_in_tree():
		var camera = get_viewport().get_camera_3d()
		if camera:
			var screen_pos = camera.unproject_position(global_position)
			var new_screen_y = screen_pos.y + event.screen_relative.y
			var depth = global_position.distance_to(camera.global_position)
			var world_pos = camera.project_position(screen_pos, depth)
			var new_world_pos = camera.project_position(Vector2(screen_pos.x, new_screen_y), depth)
			ScrollTarget += (new_world_pos.y - world_pos.y)
