extends Area2D
class_name SpellBase

var elements : Array[E.Element] = []
var base_damage := 10
var charge := 1

func get_damage(resistance: E.Element) -> int:
	var damage := base_damage * charge * charge * charge * elements.size()
	if elements.has(resistance):
		var damaging_elements := elements.size() - elements.count(resistance)
		damage = int(damage / elements.size() * damaging_elements)
	return damage
