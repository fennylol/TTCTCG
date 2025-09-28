extends Node

var RNG := RandomNumberGenerator.new()
const SEED = 0

func _ready() -> void:
	if SEED > 0: RNG.set_seed(SEED)

func random_value() -> float: 
	var rand = RNG.randf() 
	while floor(rand):
		rand = RNG.randf() 
	return rand

# [from, to]
#func randomi_range(to : int, from : int = 0) -> int: return RNG.randi_range(from, to)
