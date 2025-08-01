extends Node

@warning_ignore_start("unused_signal")

signal player_health_changed(new_health: int)
signal damage_player(damage: int)
signal game_over()
signal game_won()

signal element_selected(pos: int, element: E.Element)
signal elements_cleared()

signal enemy_died()
signal damage_dealt(damage: int)

signal tick()

@warning_ignore_restore("unused_signal")
