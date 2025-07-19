extends EnemyBase


func _ready() -> void:
	attack_mode_changed.connect(_on_attack_mode_changed)
	died.connect(_oh_no_i_died)

func _on_attack_mode_changed() -> void:
	$AttackTimer.start()

func _on_area_entered(area: Area2D) -> void:
	var damage_taken := self.on_area_entered(area)
	if damage_taken > 0:
		$EnemyDamagePopup.display_damage(damage_taken)

func _on_attack_timer_timeout() -> void:
	attack()

func _oh_no_i_died() -> void:
	$DeathTimer.start()
	$CollisionShape2D.set_deferred("disabled", true)

func _on_death_timer_timeout() -> void:
	queue_free()
