extends EnemyBase


func _ready() -> void:
	speed = 80
	damage = 5
	health = 120
	attack_mode_changed.connect(_on_attack_mode_changed)
	died.connect(_oh_no_i_died)
	damage_taken.connect(_on_damage_taken)
	ready()
	$Barrel.self_modulate = G.element_colors[resistance]
	$AnimationPlayer.play("WALK")

func _on_attack_mode_changed() -> void:
	$AttackTimer.start()
	$AnimationPlayer.stop()

func _on_area_entered(area: Area2D) -> void:
	self.on_area_entered(area)

func _on_damage_taken(damage: int) -> void:
	if damage > 0:
		$EnemyDamagePopup.display_damage(damage)

func _on_attack_timer_timeout() -> void:
	if is_dead:
		return
	attack()
	$AnimationPlayer.play("ATTACK")

func _oh_no_i_died() -> void:
	$AnimationPlayer.stop()
	$AnimationPlayer.play("DEATH")
	$CollisionShape2D.set_deferred("disabled", true)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "DEATH":
		queue_free()
