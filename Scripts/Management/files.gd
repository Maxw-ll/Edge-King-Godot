extends Node

class_name File

var save_path: String = "user://save.dat"

var game_data: Dictionary = {
	"Deaths": 0,
	"Level": 1,
	"Timer": 0
}

func save_data() -> void:
	var file: File = File.new()
	var state = file.open(save_path, File.WRITE)
	if state == OK:
		file.store_var(game_data)
		file.close()

func load_data() -> void:
	var file: File = File.new()
	if file.file_exists(save_path):
		var  state = file.open(save_path, File.READ)
		if state == OK:
			game_data = file.get_var()
			file.close()
	
