extends Node2D

@export var enemy_spawn_timer : Timer

var soldier_enemy_scene := preload("res://scenes/enemies/soldier-enemy/soldier_enemy.tscn")
var brute_enemy_scene := preload("res://scenes/enemies/brute-enemy/brute_enemy.tscn")

var _enemy_count := 0

func _ready() -> void:
	enemy_spawn_timer.start()
	S.enemy_died.connect(_on_enemy_died)
	spawn_new_enemy()

func _on_enemy_died() -> void:
	spawn_new_enemy()

func spawn_new_enemy() -> void:
	_enemy_count = _enemy_count + 1
	randomize()
	var enemy : EnemyBase = brute_enemy_scene.instantiate() if randi() % 5 == 0 else soldier_enemy_scene.instantiate()
	enemy.position = _get_random_spawn_position()
	call_deferred("add_child", enemy)

func _get_random_spawn_position() -> Vector2:
	var y = randi_range(-100, 1180)
	var x = -100 if randi() % 2 == 0 else 2020
	return Vector2(x, y)
