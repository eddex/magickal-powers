extends Control

func _ready() -> void:
	visible = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		visible = !visible


func _on_continue_button_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main-menu/main_menu.tscn")
