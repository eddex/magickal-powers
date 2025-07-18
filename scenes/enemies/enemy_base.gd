extends Area2D
class_name EnemyBase

@export var target: Marker2D
var speed := 100
var attack_mode := false
var health := 100
var damage := 5

signal attack_mode_changed()

func _physics_process(delta: float) -> void:
	look_at(target.global_position)
	if !attack_mode: # attack means the enemy stands next to the castle already
		position += transform.x * speed * delta

func on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		attack_mode = true
		attack_mode_changed.emit()
	if area.is_in_group("spell"):
		print("enemy hit")

func attack() -> void:
	S.damage_player.emit(damage)
