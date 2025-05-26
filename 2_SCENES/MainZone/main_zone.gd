extends Node3D

var Collection: ContentCollection
@onready var PackZone = $PackZone

func _init() -> void:
	Collection = ContentCollection.new()

func _ready() -> void:
	Collection._load()
	Collection.set_name("WorkingCollection")
	add_child(Collection)
	PackZone.Results.connect(Collection.recieve_cards)
	PackZone.DEBUG_add_pack()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("save"): Collection._save()
	if Input.is_action_just_pressed("load"): Collection._load()
