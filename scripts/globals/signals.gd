extends Node

@warning_ignore_start("unused_signal")

signal player_health_changed(new_health: int)
signal damage_player(damage: int)
signal game_over()

@warning_ignore_restore("unused_signal")
