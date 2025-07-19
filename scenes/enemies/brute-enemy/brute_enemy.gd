extends EnemyBase

func _ready() -> void:
	speed = 50
	damage = 15
	attack_mode_changed.connect(_on_attack_mode_changed)
	died.connect(_oh_no_i_died)
	damage_taken.connect(_on_damage_taken)
	ready()

func _on_attack_mode_changed() -> void:
	$AttackTimer.start()

func _on_area_entered(area: Area2D) -> void:
	self.on_area_entered(area)

func _on_damage_taken(damage: int) -> void:
	if damage > 0:
		$EnemyDamagePopup.display_damage(damage)

func _on_attack_timer_timeout() -> void:
	attack()

func _oh_no_i_died() -> void:
	$DeathTimer.start()
	$CollisionShape2D.set_deferred("disabled", true)

func _on_death_timer_timeout() -> void:
	queue_free()
