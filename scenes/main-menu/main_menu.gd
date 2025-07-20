extends Control

var game_scene := preload("res://scenes/game/game.tscn")

func _ready() -> void:
	$MusicAudioStreamPlayer.play()

func _on_play_game_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)

func _on_how_to_play_button_pressed() -> void:
	$Tutorial.show()
	$TutorialOpenAudioStreamPlayer.play()

func _on_close_tutorial_button_pressed() -> void:
	$Tutorial.hide()
	$TutorialCloseAudioStreamPlayer.play()


func _on_settings_button_pressed() -> void:
	$Settings.show()
	$TutorialOpenAudioStreamPlayer.play()


func _on_settings_on_settings_closed() -> void:
	$TutorialCloseAudioStreamPlayer.play()
