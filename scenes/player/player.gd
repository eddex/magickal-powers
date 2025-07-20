extends Area2D

@export var projectile_parent_node : Node2D

var spell_projectile_scene : PackedScene = preload("res://scenes/spells/Projectile/projectile.tscn")

var selected_elements :  Array[E.Element] = []
var spell_charging := false
var spell_charge_time := 0.0
var fully_charged_sound_played := false

func _physics_process(_delta: float) -> void:
	%MovableTop.look_at(get_global_mouse_position())

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("element_earth") and selected_elements.size() < 3:
		selected_elements.append(E.Element.Earth)
		S.element_selected.emit(selected_elements.size() - 1, E.Element.Earth)
	if Input.is_action_just_pressed("element_fire") and selected_elements.size() < 3:
		selected_elements.append(E.Element.Fire)
		S.element_selected.emit(selected_elements.size() - 1, E.Element.Fire)
	if Input.is_action_just_pressed("element_water") and selected_elements.size() < 3:
		selected_elements.append(E.Element.Water)
		S.element_selected.emit(selected_elements.size() - 1, E.Element.Water)
	
	if selected_elements.size() > 0:
		if spell_charging:
			spell_charge_time += delta
		if spell_charge_time > 2 and not fully_charged_sound_played:
			fully_charged_sound_played = true
			$FullyChargedAudioStreamPlayer.play()
		if Input.is_action_just_pressed("primary_action"):
			$ChargeAudioStreamPlayer.play(0.0)
			spell_charging = true
			%ChargeAnimationPlayer.play("CHARGE")
			%ChargeAnimationPlayer.queue("CHARGED")
		if Input.is_action_just_released("primary_action"):
			fully_charged_sound_played = false
			$ChargeAudioStreamPlayer.stop()
			$ShootAudioStreamPlayer.play()
			var charge := spell_charge_time as int + 1
			var spell : SpellBase = spell_projectile_scene.instantiate()
			spell.transform = %SpellSpawnPoint.global_transform
			spell.charge = charge if charge < 3 else 3
			spell.elements = selected_elements.duplicate() # otherwise it is cleared in the spell too :)
			projectile_parent_node.add_child(spell)
			spell_charging = false
			spell_charge_time = 0.0
			selected_elements.clear()
			S.elements_cleared.emit()
			%ChargeAnimationPlayer.stop()
			%ChargeAnimationPlayer.play("RESET")
