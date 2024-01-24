extends Node

const WHITE: PackedScene = preload("res://Scenes/Blocos/white_floor.tscn")
const BLACK: PackedScene = preload("res://Scenes/Blocos/black_floor.tscn")
const BLUE: PackedScene =  preload("res://Scenes/Blocos/blue_floor.tscn")
const RED: PackedScene =   preload("res://Scenes/Blocos/red_floor.tscn")
const CUBO: PackedScene = preload("res://Scenes/Player/player.tscn")
const CREDITOS: PackedScene = preload("res://Scenes/UI/credits.tscn")

var current_level: int = 1
var pisos_totais: int = 0
var begin_map: Vector2 = Vector2(600, 150)
var cubo = CUBO.instance()


export onready var maps: Node = get_node("Levels")
var mapa: Array = []

	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_esc"):
		pass
func _ready() -> void:
	var file: File = File.new()
	if file.file_exists("user://save.dat"):
		Files.load_data()
		current_level = Files.game_data["Level"]
	drawmap()

func drawmap() -> void:
	
	if current_level > 30:
		var credits = CREDITOS.instance()
		get_parent().call_deferred("add_child", credits)
		queue_free()
		return

	pisos_totais = 0
	
	for index in get_child_count():
		if get_child(index) is Floor:
			get_child(index).queue_free()
			
	
	mapa = maps.array_maps[current_level]

	var y: int = 0

	for linha in mapa:
		var x: int = 0
		for celula in linha:
			if celula == '1' or celula == '5' or celula == "2":
				var white = WHITE.instance()
				white.global_position = Vector2(begin_map.x + 21*x - 30*y, begin_map.y + 21*x + 15*y)
				call_deferred("add_child",  white) 
				if celula == "2":
					white.white_and_black = 1
				pisos_totais += 1

			if celula == '2':
				var black = BLACK.instance()
				black.global_position = Vector2(begin_map.x + 21*x - 30*y, begin_map.y + 21*x + 15*y)
				call_deferred("add_child",  black)
				
			if celula == '3':
				var blue = BLUE.instance()
				blue.global_position = Vector2(begin_map.x + 21*x - 30*y, begin_map.y + 21*x + 15*y)
				call_deferred("add_child",  blue)
				pisos_totais += 1

			if celula == '4':
				var red = RED.instance()
				red.global_position = Vector2(begin_map.x + 21*x - 30*y, begin_map.y + 21*x + 15*y)
				call_deferred("add_child",  red)
		
				
			if celula == '5':
				cubo = CUBO.instance()
				cubo.global_position = Vector2(begin_map.x + 21*x - 30*y, begin_map.y - 12 + 21*x + 15*y)
				call_deferred("add_child",  cubo)
		
			x += 1
		y += 1
		
	cubo.pisos = pisos_totais
		
	
