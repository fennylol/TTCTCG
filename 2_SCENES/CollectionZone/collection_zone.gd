extends Node3D

signal finished

const SPACING_WIDTH: float = 0.25
const SPACING_HEIGHT: float = 0.25
const SCROLL_TARGET_SPEED: float = 0.5
const SCROLL_SPEED: float = 5
const ROT_SPEED: float = 5
const Z_SCROLL_SPEED: float = 5
const SUBSET_VIEWING_DIST: float = -10

@onready var UI: Control = $CollectionUI
var DisplayedCount: int = 0
var DisplayedWidth: int = 3
var WorkingCollection: ContentCollection
var HolderNode: Node3D
var SubsetHolderNode: Node3D
var ClickTarget: Node3D

var ScrollTarget: float = 0.0
var ViewingSubset: bool = false

func _init() -> void:
	WorkingCollection = ContentCollection.new()
	# create node to hold content
	_new_holder()
	_new_subset_holder()

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
		HolderNode.position.z = lerpf(HolderNode.position.z, float(ViewingSubset)*SUBSET_VIEWING_DIST, delta*SCROLL_SPEED)


func display_collection(SortOrder : ContentCollection.SortOrders = ContentCollection.SortOrders.TYPE, Width : int = 3, MaxDisplayCount : int = 1, ViewAllContent : bool = false):
	# reset values
	DisplayedCount = 0
	DisplayedWidth = Width
	
	_new_subset_holder()
	# populate HolderNode
	var collection: Dictionary = WorkingCollection.collection
	
	match SortOrder:
		ContentCollection.SortOrders.EXPANSION:
			for expansion in DATA.ExpansionIDs:
				for type in DATA.ContentTypes:
					for rarity in DATA.Rarities:
						for content_ID in collection[expansion]["ATK"][type][rarity]:
							var ch: ContentHolder =  display_content(expansion, type, rarity, content_ID, collection, HolderNode)
							
		ContentCollection.SortOrders.TYPE:
			for type in DATA.ContentTypes:
				for rarity in DATA.Rarities:
					for expansion in DATA.ExpansionIDs:
						for content_ID in collection[expansion]["ATK"][type][rarity]:
							var ch: ContentHolder = display_content(expansion, type, rarity, content_ID, collection, HolderNode)
							
							var child_count = 0
							var paired_rarities_dict = collection[expansion]["ATK"][type][rarity][content_ID]
							for paired_rarity in paired_rarities_dict:
								for paired_ID in paired_rarities_dict[paired_rarity]:
									child_count += 1
									var pair = DATA.get_expansion_content(DATA.ExpansionIDs[expansion], DATA.Rarities[paired_rarity], DATA.ContentTypes[type], paired_ID)
									pair.position.z -= 0.5*child_count
									ch.add_child(pair)
							
		ContentCollection.SortOrders.RARITY:
			for rarity in DATA.Rarities:
				for type in DATA.ContentTypes:
					for expansion in DATA.ExpansionIDs:
						for content_ID in collection[expansion]["ATK"][type][rarity]:
							display_content(expansion, type, rarity, content_ID, collection, HolderNode)

func display_content(expansion, type, rarity, content_ID, collection, container_node) -> ContentHolder:
	var card: Card = DATA.get_expansion_content(DATA.ExpansionIDs[expansion], DATA.Rarities[rarity], DATA.ContentTypes[type], content_ID)
	var plain_name: String = DATA.get_expansion_content(DATA.ExpansionIDs[expansion], DATA.Rarities[rarity], DATA.ContentTypes[type], content_ID).Name.replace(" ", "_").to_lower()

	var content_holder := ContentHolder.new(plain_name)
	container_node.add_child(content_holder)
	content_holder.add_child(card)

	var pos := Vector3(0,0,0)
	pos.x = (DisplayedCount%DisplayedWidth)*(Card.CARD_WIDTH+SPACING_WIDTH)
	pos.y = -(DisplayedCount/DisplayedWidth)*(Card.CARD_HEIGHT+SPACING_HEIGHT)
	content_holder.position = pos
	
	var clickCallback = func(): card_clicked(card, content_holder)
	if !ViewingSubset: content_holder.clicked.connect(clickCallback)
	#var clickCallback = func():
		#ViewingSubset = true
		#
		#print(card.Name, " (",rarity," ", type,")")
		#for paired_rarity in collection[expansion]["ATK"][type][rarity][content_ID]:
			#for paired_ID in collection[expansion]["ATK"][type][rarity][content_ID][paired_rarity]:
				#var temp_count = DisplayedCount
				#DisplayedCount = 0
				#var paired_card: Card = DATA.get_expansion_content(DATA.ExpansionIDs[expansion], DATA.Rarities[paired_rarity], DATA.ContentTypes[type], content_ID)
				#var count: int = collection[expansion]["ATK"][type][rarity][content_ID][paired_rarity][paired_ID]
				#print("   ",paired_card.Name,": ", count, " (",paired_rarity," ", DATA.ContentTypes.find_key(paired_card.Type),")")
				#for i in count:
					#display_content(expansion, type, paired_rarity, paired_ID, collection, SubsetHolderNode)
				#DisplayedCount = temp_count
		#print("")
	#
	#if !ViewingSubset: content_holder.clicked.connect(clickCallback)
	
	DisplayedCount += 1
	return content_holder


func card_clicked(card: Card, content_holder: ContentHolder):
	print(card.name)
	var how_many_kids: int = content_holder.get_child_count()-1
	

## passthrough
func recieve_cards(ExpansionID : DATA.ExpansionIDs, CardList : Array[Card]):
	WorkingCollection.recieve_cards(ExpansionID, CardList)


func _on_back_button_pressed() -> void: 
	if ViewingSubset:
		ViewingSubset = false
		_new_subset_holder()
	# create node to hold content
	else:
		_new_holder()
		finished.emit()

func _on_reset_button_pressed() -> void:
	WorkingCollection.queue_free()
	WorkingCollection = ContentCollection.new()
	add_child(WorkingCollection)
	WorkingCollection.set_name("WorkingCollection")
	WorkingCollection._save()
	
	_new_holder()
	display_collection()

func _on_visibility_changed() -> void:
	UI.set_visible(visible)

func _new_holder() -> void:
	if HolderNode: HolderNode.queue_free()
	HolderNode = Node3D.new()
	add_child(HolderNode)
	HolderNode.set_name("HolderNode")
	HolderNode.position.x = -(DisplayedWidth-1)/2.0 * (Card.CARD_WIDTH+SPACING_WIDTH)
	HolderNode.position.y = 0

func _new_subset_holder() -> void:
	if SubsetHolderNode: SubsetHolderNode.queue_free()
	SubsetHolderNode = Node3D.new()
	HolderNode.add_child(SubsetHolderNode)
	SubsetHolderNode.set_name("HolderNode")
	SubsetHolderNode.position.x = 0#-(DisplayedWidth-1)/2.0 * (Card.CARD_WIDTH+SPACING_WIDTH)
	SubsetHolderNode.position.z = -SUBSET_VIEWING_DIST
	SubsetHolderNode.position.y = 0


func _on_collection_ui_sorting_by(SortOrder: ContentCollection.SortOrders) -> void:
	_new_holder()
	display_collection(SortOrder)
