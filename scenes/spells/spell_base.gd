extends Area2D
class_name SpellBase

var elements : Array[E.Element] = []
var base_damage := 10
var charge := 1

func get_damage(resistance: E.Element) -> int:
	var damage := base_damage * charge * charge * charge * elements.size()
	if elements.has(resistance):
		damage = int(damage * 0.3)
	return damage
