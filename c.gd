extends Node2D

signal morreu

@onready var player = get_node("RonaldoPernaDeElefante")
var player_morreu = false

func _physics_process(delta):
	pass

func _on_life_morreu():
	player_morreu = true

func mudar():
	if player == null:
		player_morreu = true
		return
	var pos = player.position
	return pos
	
func adicionar_morte():
	emit_signal("morreu")



