extends Control

func _ready() -> void:
	$GameOver.hide()
	S.player_health_changed.connect(_on_player_health_chnaged)
	S.game_over.connect(_on_game_over)


func _on_player_health_chnaged(new_health: int) -> void:
	%PlayerHealth.value = new_health

func _on_game_over() -> void:
	$GameOver.show()


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main-menu/main_menu.tscn")
