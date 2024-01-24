extends Control

class_name Credits

onready var deaths: Label = get_node("ColorRect/Mortes")
onready var time_total: Label = get_node("ColorRect/Tempo")

func _ready():
	deaths.text = "Deaths: " + str(Files.game_data["Deaths"])
	var time_c =  Files.game_data["Timer"]
	# warning-ignore:integer_division
	var hours: int = (time_c/3600)
	# warning-ignore:integer_division
	var minutes: int = (time_c%3600)/60
	var seconds: int = (time_c%3600)%60
	time_total.text = "Timer: " + text_tratement(hours) +":"+ text_tratement(minutes) +":"+ text_tratement(seconds)


func text_tratement(number: int) -> String:
	if number <= 9:
		return "0" +str(number)
	else:
		return str(number)
