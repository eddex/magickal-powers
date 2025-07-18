extends EnemyBase

func _ready() -> void:
	speed = 50
	damage = 15
	attack_mode_changed.connect(_on_attack_mode_changed)


func _on_attack_mode_changed() -> void:
	$AttackTimer.start()


func _on_area_entered(area: Area2D) -> void:
	self.on_area_entered(area)


func _on_attack_timer_timeout() -> void:
	attack()
