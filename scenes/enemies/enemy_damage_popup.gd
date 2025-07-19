extends Node2D

func _ready() -> void:
	$Label.self_modulate = Color(1.0, 1.0, 1.0, 0.0) # hide

func display_damage(damage: int) -> void:
	var parent : Area2D = owner
	rotation = parent.rotation * -1
	$Label.text = str(damage)
	$AnimationPlayer.play("DISPLAY_DAMAGE_AND_FADE_OUT")
