extends Control

var kills := 0
var score := 0

func _ready() -> void:
	$GameOver.hide()
	$GameStartedAudioStreamPlayer.play()
	S.player_health_changed.connect(_on_player_health_chnaged)
	S.game_over.connect(_on_game_over)
	S.element_selected.connect(_on_element_selected)
	S.elements_cleared.connect(_on_elements_cleared)
	S.damage_dealt.connect(_on_damage_dealt)
	S.enemy_died.connect(_on_enemy_died)

func _on_player_health_chnaged(new_health: int) -> void:
	%PlayerHealth.value = new_health
	%PlayerHealth/Label.text = str(new_health)

func _on_game_over() -> void:
	$GameOver.show()
	$GameOverAudioStreamPlayer.play()
	%ScoreLabel.text = str(score)
	%KillsLabel.text = str(kills)
	%NewHighScore.visible = G.high_score < score
	if G.high_score < score:
		G.high_score = score
		
	get_tree().paused = true

func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main-menu/main_menu.tscn")

func _on_element_selected(pos: int, element: E.Element) -> void:
	var element_indicator : TextureRect = %ElementIndicators.get_child(pos)
	element_indicator.self_modulate = G.element_colors[element]

func _on_elements_cleared() -> void:
	for element_indicator : TextureRect in %ElementIndicators.get_children():
		element_indicator.self_modulate = Color(1.0, 1.0, 1.0, 0.5)

func _on_damage_dealt(damage: int) -> void:
	score = score + damage
	_update_hud_score()

func _on_enemy_died() -> void:
	kills = kills + 1
	score = score + 250
	_update_hud_score()

func _update_hud_score() -> void:
	%HudScoreLabel.text = str(score)
