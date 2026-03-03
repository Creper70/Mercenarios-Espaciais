extends Area2D

signal ataqueEspinho(dano)

@onready var sprite = $Sprite
@onready var em_cima = false
@export var tempo_voltar: float = 0.8 
@onready var Spike = $Spike
@onready var Danger = $Danger
@onready var timer = $Timer



func _process(delta):
	if sprite.get_frame() == 2 and em_cima == true and timer.is_stopped():
		emit_signal("ataqueEspinho")
		timer.start()
		
	if sprite.get_frame() == 2 and em_cima == false:
		await get_tree().create_timer(tempo_voltar).timeout
		sprite.set_frame(0)
func _on_body_entered(body):
		if body.is_in_group("character") and sprite.get_frame() == 0:
			if sprite.get_frame() >= 0:
				em_cima = true
			await get_tree().create_timer(0.3).timeout
			Danger.play()
			sprite.set_frame(1)
			await get_tree().create_timer(1.5).timeout
			Spike.play()
			if em_cima == true:
				emit_signal("ataqueEspinho")
				timer.stop
			sprite.set_frame(2)
		elif sprite.get_frame() == 1 or sprite.get_frame() == 2:
			em_cima = true
	
func _on_body_exited(body):
	if body.is_in_group("character"):
		em_cima = false
