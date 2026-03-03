extends CharacterBody2D

const SPEED = 300.0


func _physics_process(delta):
	
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	velocity.x = direction_x * SPEED
	velocity.y = direction_y * SPEED
	
	if direction_x == 0 or direction_y == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED)
