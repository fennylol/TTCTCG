extends Node3D

signal finished

func enter_game_zone():
	LOGGER.log_msg("GAMING GAMING GAMIN?G", LOGGER.Flags.MSG_STDOUT)
	await get_tree().create_timer(1.0).timeout
	finished.emit()
