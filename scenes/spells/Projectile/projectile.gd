extends SpellBase

var speed := 750
var age := 0.0
var strength := 1
var spell : E.SpellElements = E.SpellElements.Earth

var _element_colors := {
	E.Element.Earth: Color(0.453, 0.205, 0.0),
	E.Element.Fire:Color(1.0, 0.502, 0.0),
	E.Element.Water: Color(0.0, 0.478, 1.0)
}

func _ready() -> void:
	$Effects/AnimationPlayer.play("ROTATE")
	$Sprite.scale = Vector2i(strength, strength)
	$Sprite.self_modulate = _element_colors[E.Element.Earth]
	$Effects/Twirl1.self_modulate = _element_colors[E.Element.Earth]
	$Effects/Twirl2.self_modulate = _element_colors[E.Element.Earth]
	if elements.has(E.Element.Fire) and not elements.has(E.Element.Water):
		$Effects/Twirl1.self_modulate = _element_colors[E.Element.Fire]
		$Effects/Twirl2.self_modulate = _element_colors[E.Element.Fire]
	if elements.has(E.Element.Fire) and elements.has(E.Element.Water):
		$Effects/Twirl1.self_modulate = _element_colors[E.Element.Water]
		$Effects/Twirl2.self_modulate = _element_colors[E.Element.Fire]
	if not elements.has(E.Element.Fire) and elements.has(E.Element.Water):
		$Effects/Twirl1.self_modulate = _element_colors[E.Element.Water]
		$Effects/Twirl2.self_modulate = _element_colors[E.Element.Water]


func _physics_process(delta: float) -> void:
	age += delta
	if age > 5:
		queue_free()
	position += transform.x * speed * delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") and speed > 0:
		speed = 0
		age = 0
		$Sprite.visible = false
		$Effects/Twirl1.visible = false
		$Effects/Twirl2.visible = false
		$ExplosionCollisionShape.set_deferred("disabled", false)
		$ExplosionCollisionShape/Timer.start()
		$Effects/SmokeParticles.emitting = true
		if elements.has(E.Element.Fire):
			$Effects/FireParticles.emitting = true


func _on_explosion_shape_timer_timeout() -> void:
	$ExplosionCollisionShape.set_deferred("disabled", true)
	$ImpactCollisionShape.set_deferred("disabled", true)
