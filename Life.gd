extends Node2D

signal morreu

var vida = 4
@onready var Life = $coracoes


func _on_ronaldo_perna_de_elefante_health(dano = 1):
	vida -= dano
	Life.set_frame(vida)
	if vida <= 0:
		emit_signal("morreu")


func _on_espinho_ataque_espinho(dano = 1):
	if vida <= 0:
		emit_signal("morreu")
	Life.set_frame(vida)
	vida -= dano




