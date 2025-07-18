extends Control

func _ready() -> void:
	S.player_health_changed.connect(_on_player_health_chnaged)


func _on_player_health_chnaged(new_health: int) -> void:
	%PlayerHealth.value = new_health
