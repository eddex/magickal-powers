extends Area2D
class_name EnemyBase

var speed := 100
var _speed_modifier := 1.0
var attack_mode := false
var is_dead := false
var health := 100
var damage := 5
var resistance := E.Element.None

# elemental spell effects
var effect_timer_wait_time := 0.2
var is_burning := 0.0
var is_wet := 0.0

signal attack_mode_changed()
signal damage_taken(damage: int)
signal died()

func ready() -> void:
	S.tick.connect(_on_effect_timer_timeout)
	resistance = [E.Element.None, E.Element.Earth, E.Element.Fire, E.Element.Water][randi_range(0, 3)]

func _on_effect_timer_timeout() -> void:
	# update effects
	if is_burning > 0 and resistance != E.Element.Fire:
		is_burning = max(0, is_burning - effect_timer_wait_time)
		take_damage(1)
	if is_wet > 0 and resistance != E.Element.Water:
		is_wet = max(0, is_wet - effect_timer_wait_time)
		_speed_modifier = 0.5 if is_wet > 0 else 1
		
func _physics_process(delta: float) -> void:
	look_at(Vector2(960.0, 540.0)) # center of the screen
	if !attack_mode: # attack means the enemy stands next to the castle already
		position += transform.x * speed * _speed_modifier * delta

## returns damage taken
func on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		attack_mode = true
		attack_mode_changed.emit()
	if area.is_in_group("spell") and not is_dead:
		var spell : SpellBase = area
		var damage_taken := spell.get_damage(resistance)
		if spell.elements.has(E.Element.Fire):
			is_burning = 2.0
		if spell.elements.has(E.Element.Water):
			is_wet = 2.0
		take_damage(damage_taken)

func attack() -> void:
	S.damage_player.emit(damage)

func take_damage(damage: int) -> void:
	if health <= 0: # happens on burn effect
		return
	var new_health = health - damage
	if new_health <= 0:
		new_health = 0
		S.enemy_died.emit()
		died.emit()
		is_dead = true
		speed = 0
		attack_mode = false
	health = new_health
	damage_taken.emit(damage)
