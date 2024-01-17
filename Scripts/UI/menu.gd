extends Control

class_name Menu

onready var button_continue = get_node("Control/VBoxContainer/Continue")



func _ready() -> void:
	var file: File = File.new()
	if !file.file_exists("user://save.dat"):
		button_continue.disabled = true
	for button in get_tree().get_nodes_in_group("button"):
		
		button.connect("pressed", self, "on_button_pressed", [button])
		button.connect("mouse_exited", self, "mouse_interaction", [button, "exited"])
		button.connect("mouse_entered", self, "mouse_interaction", [button, "entered"])

func on_button_pressed(button: Button) -> void:
	match button.name:
		"New game":
			Files.game_data["Deaths"] = 0
			Files.game_data["Level"] = 1
			Files.game_data["Timer"] = 0
			Files.save_data()
			var _n = get_tree().change_scene("res://Scenes/Levels/level.tscn")
		"Continue":
			var _n = get_tree().change_scene("res://Scenes/Levels/level.tscn")
		"Controls":
			pass
		"Exit":
			get_tree().quit()
		"Link":
			var _n = OS.shell_open("https://github.com/Maxw-ll")

func mouse_interaction(button: Button, interaction: String) -> void:
	if button.disabled == false:
		match interaction:
			"entered":
				button.modulate.a = 0.5
			"exited":
				button.modulate.a = 1


