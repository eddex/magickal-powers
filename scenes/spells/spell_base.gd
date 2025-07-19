extends Area2D
class_name SpellBase

var elements : Array[E.Element] = []
var damage := 50

func get_spell_type() -> E.SpellType:
	return E.SpellType.Projectile
