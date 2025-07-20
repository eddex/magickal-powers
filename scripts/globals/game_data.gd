extends Node

var element_colors := {
	E.Element.None: Color(0.504, 0.496, 0.488),
	E.Element.Earth: Color(0.453, 0.205, 0.0),
	E.Element.Fire:Color(1.0, 0.502, 0.0),
	E.Element.Water: Color(0.0, 0.478, 1.0)
}

var high_score := 0
var music_volume := 40
var sfx_volume := 60

func _ready() -> void:
	AudioServer.set_bus_volume_linear(1, sfx_volume / 100.0)
	AudioServer.set_bus_volume_linear(2, music_volume / 100.0)

func update_music_volume(vol: int) -> void:
	music_volume = vol
	AudioServer.set_bus_volume_linear(2, music_volume / 100.0)

func update_sfx_volume(vol: int) -> void:
	sfx_volume = vol
	AudioServer.set_bus_volume_linear(1, sfx_volume / 100.0)
