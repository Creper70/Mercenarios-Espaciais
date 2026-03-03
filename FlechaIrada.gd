extends CharacterBody2D
@export var Speed = 1200

func _ready():
	pass

func _physics_process(delta):
	move_and_slide()
	position += transform.x * Speed * delta

	if is_on_wall() or is_on_floor() or is_on_ceiling() or is_in_group("enemy"):
		queue_free()
	
func olhadinha():
	look_at(get_global_mouse_position())
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
