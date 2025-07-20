extends Control

signal difficulty_selected(difficulty: E.Difficulty)

func _on_easy_button_pressed() -> void:
	_on_button_pressed(E.Difficulty.Easy)

func _on_normal_button_pressed() -> void:
	_on_button_pressed(E.Difficulty.Normal)

func _on_hard_button_pressed() -> void:
	_on_button_pressed(E.Difficulty.Hard)

func _on_endless_button_pressed() -> void:
	_on_button_pressed(E.Difficulty.Endless)

func _on_button_pressed(difficulty: E.Difficulty) -> void:
	difficulty_selected.emit(difficulty)
	hide()
	$AudioStreamPlayer.play()
