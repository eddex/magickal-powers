extends Node2D

var player_health := 100

func _ready() -> void:
	S.damage_player.connect(_on_damage_player)
	S.player_health_changed.emit(player_health)
	$EffectTickTimer.start()
	$MusicAudioStreamPlayer.play()
	$UI/HUD.hide()
	get_tree().paused = true

func _on_damage_player(damage: int) -> void:
	var new_player_health := player_health - damage
	player_health = 0 if new_player_health < 0 else new_player_health
	S.player_health_changed.emit(player_health)
	if player_health == 0:
		S.game_over.emit()
		$MusicAudioStreamPlayer.pitch_scale = 0.75


func _on_enemy_spawn_timer_timeout() -> void:
	$Enemies.spawn_new_enemy()


func _on_effect_tick_timer_timeout() -> void:
	S.tick.emit()


func _on_difficulty_difficulty_selected(difficulty: E.Difficulty) -> void:
	$Enemies.difficulty = difficulty
	$UI/HUD.show()
	get_tree().paused = false
