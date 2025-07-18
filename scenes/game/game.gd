extends Node2D

var player_health := 100

func _ready() -> void:
	S.damage_player.connect(_on_damage_player)
	S.player_health_changed.emit(player_health)

func _on_damage_player(damage: int) -> void:
	var new_player_health := player_health - damage
	print("health ", player_health, ", damage: ", damage, ", new: ", new_player_health)
	player_health = 0 if new_player_health < 0 else new_player_health
	S.player_health_changed.emit(new_player_health)
	# TODO: Handle game over
	
