extends Node3D
class_name ContentGrid

signal CardClicked(card: Card, content_holder: ContentHolder)

const SPACING_WIDTH: float = 0.25
const SPACING_HEIGHT: float = 0.25
const SCROLL_TARGET_SPEED: float = 0.5
const SCROLL_SPEED: float = 5

var DisplayedCount: int = 0
var DisplayedWidth: int = 3

var ScrollTarget: float = 0.0
var SlideTarget: float = 0.0
#var BuildingDeck: bool = false

func _init(DisplayedContent: ContentCollection, RowWidth : int = DisplayedWidth):
	DisplayedWidth = RowWidth
	position.x = -(DisplayedWidth-1)/2.0 * (Card.CARD_WIDTH+SPACING_WIDTH)
	SlideTarget = position.x
	var collection: Dictionary = DisplayedContent.collection
	
	for expansion in DATA.ExpansionIDs:
		for type in DATA.ContentTypes:
			for rarity in DATA.Rarities:
				for content_ID in collection[expansion]["ATK"][type][rarity]:
					var card: Card = DATA.get_expansion_content(DATA.ExpansionIDs[expansion], DATA.Rarities[rarity], DATA.ContentTypes[type], content_ID)
					var _ch: ContentHolder =  display_content(card)


func display_content(card: Card) -> ContentHolder:
	var plain_name: String = card.name.replace(" ", "_").to_lower()

	var content_holder := ContentHolder.new(plain_name)
	add_child(content_holder)
	content_holder.add_child(card)

	var pos := Vector3(0,0,0)
	pos.x = (DisplayedCount%DisplayedWidth)*(Card.CARD_WIDTH+SPACING_WIDTH)
	pos.y = -(DisplayedCount/DisplayedWidth)*(Card.CARD_HEIGHT+SPACING_HEIGHT)
	content_holder.position = pos
	
	var clickCallback = func(): CardClicked.emit(card, content_holder)
	content_holder.clicked.connect(clickCallback)
	
	DisplayedCount += 1
	return content_holder


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






#match SortOrder:
		#ContentCollection.SortOrders.EXPANSION:
			#for expansion in DATA.ExpansionIDs:
				#for type in DATA.ContentTypes:
					#for rarity in DATA.Rarities:
						#for content_ID in collection[expansion]["ATK"][type][rarity]:
							#var ch: ContentHolder =  display_content(expansion, type, rarity, content_ID, collection, HolderNode)
							#
		#ContentCollection.SortOrders.TYPE:
			#for type in DATA.ContentTypes:
				#for rarity in DATA.Rarities:
					#for expansion in DATA.ExpansionIDs:
						#for content_ID in collection[expansion]["ATK"][type][rarity]:
							#var ch: ContentHolder = display_content(expansion, type, rarity, content_ID, collection, HolderNode)
							#
							#var child_count = 0
							#var paired_rarities_dict = collection[expansion]["ATK"][type][rarity][content_ID]
							#for paired_rarity in paired_rarities_dict:
								#for paired_ID in paired_rarities_dict[paired_rarity]:
									#child_count += 1
									#var pair = DATA.get_expansion_content(DATA.ExpansionIDs[expansion], DATA.Rarities[paired_rarity], DATA.ContentTypes[type], paired_ID)
									#pair.position.z -= 0.5*child_count
									#ch.add_child(pair)
							#
		#ContentCollection.SortOrders.RARITY:
			#for rarity in DATA.Rarities:
				#for type in DATA.ContentTypes:
					#for expansion in DATA.ExpansionIDs:
						#for content_ID in collection[expansion]["ATK"][type][rarity]:
							#display_content(expansion, type, rarity, content_ID, collection, HolderNode)
