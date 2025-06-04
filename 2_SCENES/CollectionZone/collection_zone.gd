extends Node3D

signal finished

const SPACING_WIDTH: float = 0.25
const SPACING_HEIGHT: float = 0.25
const SCROLL_TARGET_SPEED: float = 0.5
const SCROLL_SPEED: float = 5
const ROT_SPEED: float = 5

@onready var UI: Control = $CollectionUI
var DisplayedCount: int = 0
var DisplayedWidth: int = 3
var WorkingCollection: ContentCollection
var HolderNode: Node3D
var ClickTarget: Node3D

var ScrollTarget: float = 0.0

func _init() -> void:
	WorkingCollection = ContentCollection.new()
	HolderNode = Node3D.new()

func _ready() -> void:
	var load_err: Error = WorkingCollection._load()
	if load_err == OK:
		add_child(WorkingCollection)
		WorkingCollection.set_name("WorkingCollection")
	else: 
		printerr("collection failed to load: ", load_err)

func _process(delta: float) -> void:
	if visible:
		var scroll: float = Input.get_axis("Up", "Down")
		if !scroll: scroll = (float(Input.is_action_just_released("Down"))-float(Input.is_action_just_released("Up")))
		ScrollTarget += scroll*SCROLL_TARGET_SPEED
		
		var row_count: int = floor(DisplayedCount/DisplayedWidth)
		var row_height: float = (Card.CARD_HEIGHT+SPACING_HEIGHT)
		ScrollTarget = max(min(ScrollTarget, (row_count*row_height)-SPACING_HEIGHT), -row_height)
		
		HolderNode.position.y = lerpf(HolderNode.position.y, ScrollTarget, delta*SCROLL_SPEED)





func display_collection(SortOrder : ContentCollection.SortOrders = ContentCollection.SortOrders.EXPANSION, Width : int = 3, MaxDisplayCount : int = 1, ViewAllContent : bool = false):
	# reset values
	DisplayedCount = 0
	DisplayedWidth = Width
	
	# create node to hold content
	HolderNode.free()
	HolderNode = Node3D.new()
	add_child(HolderNode)
	HolderNode.set_name("HolderNode")
	HolderNode.position.x = -(DisplayedWidth-1)/2.0 * (Card.CARD_WIDTH+SPACING_WIDTH)
	
	# populate HolderNode
	var collection: Dictionary = WorkingCollection.collection
	
	match SortOrder:
		ContentCollection.SortOrders.EXPANSION:
			for expansion in DATA.ExpansionIDs:
				for rarity in DATA.Rarities:
					for i in collection[expansion][rarity]:
						var plain_name: String = DATA.get_expansion_content(DATA.ExpansionIDs[expansion], DATA.Rarities[rarity], i).Name.replace(" ", "_").to_lower()
						
						var content_holder := ContentHolder.new(plain_name)
						HolderNode.add_child(content_holder)
						
						var pos := Vector3(0,0,0)
						pos.x = (DisplayedCount%DisplayedWidth)*(Card.CARD_WIDTH+SPACING_WIDTH)
						pos.y = -(DisplayedCount/DisplayedWidth)*(Card.CARD_HEIGHT+SPACING_HEIGHT)
						content_holder.position = pos
						
						content_holder.set_name(plain_name+"_holder")
						
						for j in range(min(collection[expansion][rarity][i], INF if MaxDisplayCount <= 0 else MaxDisplayCount)):
							var card = DATA.get_expansion_content(DATA.ExpansionIDs[expansion], DATA.Rarities[rarity], i)
							card.position.z -= j*0.1
							content_holder.add_child(card)
						DisplayedCount += 1
					#DisplayedCount += DisplayedWidth-(DisplayedCount%DisplayedWidth)
				#DisplayedCount += DisplayedWidth
		
		ContentCollection.SortOrders.RARITY:
			print("sorting collection by ", ContentCollection.SortOrders.RARITY)
		
		ContentCollection.SortOrders.COUNT:
			print("sorting collection by ", ContentCollection.SortOrders.COUNT)

## passthrough
func recieve_cards(ExpansionID : DATA.ExpansionIDs, CardList : Array[Card]):
	WorkingCollection.recieve_cards(ExpansionID, CardList)


func _on_back_button_pressed() -> void: 
	HolderNode.position.y = 0
	finished.emit()

func _on_reset_button_pressed() -> void:
	WorkingCollection.queue_free()
	WorkingCollection = ContentCollection.new()
	add_child(WorkingCollection)
	WorkingCollection.set_name("WorkingCollection")
	WorkingCollection._save()
	display_collection()

func _on_visibility_changed() -> void:
	UI.set_visible(visible)
