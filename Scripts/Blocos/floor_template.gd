extends Node2D
class_name Floor

export var type: String = ""
onready var animation = get_node("Floor/AnimationPlayer")

var white_and_black: int = 0
var can_teleport: bool = false

func _ready() -> void:
	if type == "blue":
		can_teleport = true


		
func animate_death() -> void:
	animation.play("death")
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()
