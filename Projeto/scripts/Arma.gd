extends Marker2D

func _process(delta) -> void:
	var mouse_position = get_global_mouse_position()
	var gun_position = self.get_global_position()
	var distance = get_global_mouse_position() - self.get_global_position()
	
	self.rotation = distance.angle()
	_sprite()
	
func _sprite() -> void:
	if rotation < -90 || rotation > 90:
		$Area2D/Texture.flip_h = true
	else:
		$Area2D/Texture.flip_h = false
