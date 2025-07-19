extends Area2D
class_name EnemyBase

var speed := 100
var attack_mode := false
var is_dead := false
var health := 100
var damage := 5
var resistance := E.Element.Fire

signal attack_mode_changed()
signal died()

func _physics_process(delta: float) -> void:
	look_at(Vector2(960.0, 540.0)) # center of the screen
	if !attack_mode: # attack means the enemy stands next to the castle already
		position += transform.x * speed * delta

## returns damage taken
func on_area_entered(area: Area2D) -> int:
	if area.is_in_group("player"):
		attack_mode = true
		attack_mode_changed.emit()
	if area.is_in_group("spell") and not is_dead:
		var spell : SpellBase = area
		var damage_taken := spell.damage
		print(resistance, " in ", spell.elements)
		if spell.elements.has(resistance):
			damage_taken = int(damage_taken * 0.3)
		take_damage(damage_taken)
		print("enemy hit for ", damage_taken)
		return damage_taken
	return 0

func attack() -> void:
	S.damage_player.emit(damage)

func take_damage(damage: int) -> void:
	var new_health = health - damage
	if new_health <= 0:
		new_health = 0
		S.enemy_died.emit()
		died.emit()
		is_dead = true
		speed = 0
		attack_mode = false
	health = new_health
