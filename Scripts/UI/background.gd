extends ParallaxBackground

class_name BackGround

export (Array, int) var layer_speed

func _physics_process(delta: float) -> void:
	for index in get_child_count():
		if get_child(index) is ParallaxLayer:
				get_child(index).motion_offset.x += layer_speed[index-1]*delta
			
