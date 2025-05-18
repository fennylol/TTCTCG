extends Node

var RNG := RandomNumberGenerator.new()
const SEED = 0

func _ready() -> void:
	if SEED > 0: RNG.set_seed(SEED)

func random_value() -> float: return RNG.randf()
