extends Node

signal player_death
signal update_level
signal save_data

func update_count_death() -> void:
	emit_signal("player_death")

func level_was_updated() -> void:
	emit_signal("update_level")

func save_data() -> void:
	emit_signal("save_data")
	
	

	
