extends Control

func _ready() -> void:
	$GameOver.hide()
	S.player_health_changed.connect(_on_player_health_chnaged)
	S.game_over.connect(_on_game_over)
	S.element_selected.connect(_on_element_selected)
	S.elements_cleared.connect(_on_elements_cleared)

func _on_player_health_chnaged(new_health: int) -> void:
	%PlayerHealth.value = new_health
	%PlayerHealth/Label.text = str(new_health)

func _on_game_over() -> void:
	$GameOver.show()

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main-menu/main_menu.tscn")

func _on_element_selected(pos: int, element: E.Element) -> void:
	var element_indicator : TextureRect = %ElementIndicators.get_child(pos)
	element_indicator.self_modulate = G.element_colors[element]

func _on_elements_cleared() -> void:
	for element_indicator : TextureRect in %ElementIndicators.get_children():
		element_indicator.self_modulate = Color(1.0, 1.0, 1.0, 0.5)
