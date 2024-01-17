extends Control

class_name UserInterface
var player_d: int = 0
var level_d: int = 1
var time_d: int = 0

onready var death_label = get_node("Control/PanelDeath/Death")
onready var level_label = get_node("Control/PanelLevel/Level")
onready var time_label = get_node("Control/PanelTimer/Time")


func _ready():
	
	var _p = Global.connect("save_data", self, "update_data")
	var _n = Global.connect("player_death", self, "update_player_death")
	var _m = Global.connect("update_level", self, "update_level_label")
	
	var file: File = File.new()
	if file.file_exists("user://save.dat"):
		Files.load_data()
		player_d = Files.game_data["Deaths"]
		level_d = Files.game_data["Level"]
		time_d = Files.game_data["Timer"]
	
	update_labels_after_load_save()
	
	
func update_labels_after_load_save() -> void:
	death_label.text = "Deaths: " + str(player_d)
	level_label.text = "Level: " + str(level_d)
# warning-ignore:integer_division
	var hours: int = (time_d/3600)
# warning-ignore:integer_division
	var minutes: int = (time_d%3600)/60
	var seconds: int = (time_d%3600)%60
	time_label.text = "Timer: " + text_tratement(hours) +":"+ text_tratement(minutes) +":"+ text_tratement(seconds)
	
func update_player_death() -> void:
	player_d += 1
	death_label.text = "Deaths: " + str(player_d)

func update_level_label() -> void:
	level_d += 1
	level_label.text = "Level: " + str(level_d)

func update_time_label() -> void:
	time_d += 1
# warning-ignore:integer_division
	var hours: int = time_d/3600
# warning-ignore:integer_division
	var minutes: int = (time_d%3600)/60
	var seconds: int = ((time_d%3600)%60)
	time_label.text = "Timer: " + text_tratement(hours) +":"+ text_tratement(minutes) +":"+ text_tratement(seconds)
	
	
func _on_Timer_timeout():
	update_time_label()

func text_tratement(number: int) -> String:
	if number <= 9:
		return "0" +str(number)
	else:
		return str(number)

# warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	if NOTIFICATION_WM_QUIT_REQUEST:
		update_data()
		
func update_data()-> void:
	Files.game_data["Deaths"] = player_d
	Files.game_data["Level"] = level_d
	Files.game_data["Timer"] = time_d
	Files.save_data()
	
