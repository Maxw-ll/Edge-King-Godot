extends KinematicBody2D

class_name Player

var pisos: int = 0
var velocity: Vector2
var colision_ref = null


func _physics_process(_delta: float) -> void:
	move_inputs()
	if colision_ref == null:
		Global.update_count_death()
		queue_free()
		get_parent().drawmap()
		
		

	

func move_inputs() -> void:
	if Input.is_action_just_pressed("ui_right"):
		position.x += 30
		position.y -= 15
		$MoveFx.play()
	elif Input.is_action_just_pressed("ui_left"):
		position.x -= 30
		position.y += 15
		$MoveFx.play()
	elif Input.is_action_just_pressed("ui_up"):
		position.x -= 21
		position.y -= 21
		$MoveFx.play()
	elif Input.is_action_just_pressed("ui_down"):
		position.x += 21
		position.y += 21
		$MoveFx.play()
	
	


func teleport(body: Node) -> void:
	for portal in get_tree().get_nodes_in_group("portal"):
		if portal != body.get_parent() and portal.can_teleport == true:
			for portals in get_tree().get_nodes_in_group("portal"):
				portals.can_teleport = false
			global_position = portal.global_position - Vector2(0.0,9.0)
			$TeleportFx.play()

					

				

func _on_Area2D_body_entered(body):
	colision_ref =  body
	var father: Node = body.get_parent()
	if father is Floor:
		var type: String = father.type
		match type:
			"blue":
				teleport(body)
			"red":
				if pisos == 0:
					Global.level_was_updated()
					father.queue_free()
					queue_free()
					get_parent().current_level += 1
					get_parent().drawmap()
				
					
					
					

func _on_AreaExited_body_exited(body):
	colision_ref = null
	var father: Node = body.get_parent()
	if father is Floor:
		var type: String = father.type
		match type:
			"white":
				if father.white_and_black == 0:
					father.animate_death()
					pisos -= 1
				else:
					father.white_and_black = 0
			"black":
				father.animate_death()
			"blue":
				father.animate_death()
				pisos -= 1 
				
func gravity(delta: float) -> void:
	velocity.y += delta*100
	
			

	
		

	
