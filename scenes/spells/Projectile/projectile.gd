extends SpellBase

var speed := 750
var age := 0.0

func _ready() -> void:
	$Effects/AnimationPlayer.play("ROTATE")
	$Sprite.scale = Vector2(charge * 0.5, charge * 0.5)
	var twirl_scale := 0.095 if charge < 3 else 0.095 * 1.5
	$Effects/Twirl1.scale = Vector2(twirl_scale, twirl_scale)
	$Effects/Twirl2.scale = Vector2(twirl_scale, twirl_scale)
	$Sprite.self_modulate = G.element_colors[E.Element.Earth]
	$Effects/Twirl1.self_modulate = G.element_colors[E.Element.Earth]
	$Effects/Twirl2.self_modulate = G.element_colors[E.Element.Earth]
	if elements.has(E.Element.Fire) and not elements.has(E.Element.Water):
		$Effects/Twirl1.self_modulate = G.element_colors[E.Element.Fire]
		$Effects/Twirl2.self_modulate = G.element_colors[E.Element.Fire]
		if not elements.has(E.Element.Earth):
			$Sprite.self_modulate = G.element_colors[E.Element.Fire]
	if elements.has(E.Element.Fire) and elements.has(E.Element.Water):
		$Effects/Twirl1.self_modulate = G.element_colors[E.Element.Water]
		$Effects/Twirl2.self_modulate = G.element_colors[E.Element.Fire]
	if not elements.has(E.Element.Fire) and elements.has(E.Element.Water):
		$Effects/Twirl1.self_modulate = G.element_colors[E.Element.Water]
		$Effects/Twirl2.self_modulate = G.element_colors[E.Element.Water]
		if not elements.has(E.Element.Earth):
			$Sprite.self_modulate = G.element_colors[E.Element.Water]


func _physics_process(delta: float) -> void:
	age += delta
	if age > 5:
		queue_free()
	position += transform.x * speed * charge * 0.5 * delta


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
		if elements.has(E.Element.Water):
			$Effects/WaterParticles.emitting = true


func _on_explosion_shape_timer_timeout() -> void:
	$ExplosionCollisionShape.set_deferred("disabled", true)
	$ImpactCollisionShape.set_deferred("disabled", true)
