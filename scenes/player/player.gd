extends Area2D

func _physics_process(_delta: float) -> void:
	%MovableTop.look_at(get_global_mouse_position())
