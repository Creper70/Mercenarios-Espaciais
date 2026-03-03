extends Sprite2D

func _process(delta):
	var rota = get_rotation_degrees()
	look_at(get_global_mouse_position())

	if get_rotation_degrees() > 360:
		set_rotation_degrees(0)
		
	if get_rotation_degrees() < 0:
		set_rotation_degrees(360)
		
	if rota <= 270 and rota >= 90:
		flip_v = true
		
	else:
		flip_v = false
