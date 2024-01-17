extends CanvasLayer

var is_paused: bool = false

func _ready():
	visible = false
	

	for button in get_tree().get_nodes_in_group("pause_button"):
		button.connect("pressed", self, "button_pressed", [button])
		

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if is_paused == false:
			get_tree().paused = true
			is_paused = true
			visible = true
		else:
			get_tree().paused = false
			is_paused = false
			visible = false
	
	

func button_pressed(button: Button) -> void:
	match button.name:
		"Resume":
			is_paused = false
			get_tree().paused = false
			visible = false
		"Menu":
			get_tree().paused = false
			Global.save_data()
			var _n = get_tree().change_scene("res://Scenes/UI/menu.tscn")
		"Exit":
			get_tree().quit()
	
