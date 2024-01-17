extends Control

class_name HomeWindo

onready var timer: Timer = get_node("Timer")
onready var texture: TextureRect = get_node("TextureRect")
onready var animation: AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	timer.start()
	


func _on_Timer_timeout():
	animation.play("fade_out")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"fade_out":
			texture.visible = false
