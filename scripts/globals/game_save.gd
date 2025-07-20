extends Node

var config = ConfigFile.new()

func _ready() -> void:
	load_from_file()

func load_from_file() -> void:
	var err = config.load("user://scores.cfg")
	if err != OK:
		return
	G.high_score = config.get_value("data", "high_score", 0)
	
func save_game() -> void:
	config.set_value("data", "high_score", G.high_score)
	config.save("user://scores.cfg")
