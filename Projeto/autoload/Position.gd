extends Marker2D



func _physics_process(delta):
	self.global_position = get_parent().position


