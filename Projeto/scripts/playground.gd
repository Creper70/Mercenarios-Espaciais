extends Node2D

signal comecou

@export var R1Inimigos: int = 15
@export var R2Inimigos: int = 20
@export var R3Inimigos: int = 30
@export var R4Inimigos: int = 100

@onready var inimigo = preload("res://Projeto/Inimigo/inimigo2.tscn")
@onready var tempo = $SpawnCooldown
@onready var tempoFinal = $SpawnCooldownFinal
@onready var cooldown = $CooldownRounds
@onready var Inicial = $Rounds/Inicial
@onready var tempoTexto = $Rounds/Tempo
@onready var rondas = $Rounds/Rondas
@onready var saidatexto = $Saida/saidatexto
@onready var saidacolisao = $Saida/Area2D/CollisionShape2D
@onready var Restart = $R
@onready var animation = $Animation
@onready var seta = $Saida/seta
@onready var musica = $Musica

var quantidade_spawned = 0
var rounds: int = 0
var morreu: int = 0
var proximo_round = false
var PlayerMorreu = false

func _ready():
	saidatexto.set_visible(false)
	Restart.set_visible(false)
	tempo.start()

func _physics_process(delta):
	print(tempoFinal.time_left)
	if Input.is_action_just_pressed("reset") and PlayerMorreu:
		get_tree().reload_current_scene()
	final()

func _on_c_morreu():
	morreu += 1

func _on_spawn_cooldown_timeout():
	if rounds == 0 and cooldown.is_stopped() and proximo_round == false:
		await get_tree().create_timer(1.5)
		Inicial.set_visible(false)
		animation.play("contagem")
		proximo_round = true

		cooldown.start()

	if cooldown.time_left < 0.9 and cooldown.time_left > 0 and rounds == 0:
		rondas.set_visible(true)
		musica.play()
		emit_signal("comecou")
		
	if cooldown.is_stopped() and proximo_round:
		rounds += 1
		Global.rounds_Global += 1
		proximo_round = false
		
	if rounds == 1:
		if quantidade_spawned < R1Inimigos and cooldown.is_stopped():
			spawn_inimigo()
			tempo.start()
			rondas.set_visible(false)

	if morreu == R1Inimigos and rounds == 1:
		morreu = 0
		quantidade_spawned = 0
		proximo_round = true
		animation.play("contagem")
		cooldown.start()

	if rounds == 2:
		if quantidade_spawned < R2Inimigos and cooldown.is_stopped():
			spawn_inimigo()
			tempo.start()
			rondas.set_visible(false)

	if morreu == R2Inimigos and rounds == 2:
		morreu = 0
		quantidade_spawned = 0
		proximo_round = true
		animation.play("contagem")
		cooldown.start()
	
	if rounds == 3:
		if quantidade_spawned < R3Inimigos and cooldown.is_stopped():
			spawn_inimigo()
			tempo.start()
			rondas.set_visible(false)
	
	if morreu == R3Inimigos and rounds == 3:
		morreu = 0
		quantidade_spawned = 0
		rounds += 1
		Global.rounds_Global += 1
		tempoFinal.start()
	
	if rounds == 4:
		if quantidade_spawned < R4Inimigos and cooldown.is_stopped():
			tempo.set_wait_time(0.3)
			tempo.start()
			spawn_inimigo()
			
	
			

func spawn_inimigo():
	var inimigo_instance = inimigo.instantiate()
	inimigo_instance.global_position = Vector2(0,0)
	$c/NavigationRegion2D.add_child(inimigo_instance)
	quantidade_spawned += 1



func _on_inimigo_morri():
	morreu += 1

func final():
	if morreu == R3Inimigos:
		saidatexto.set_visible(true)
		saidacolisao.set_disabled(false)
		seta.set_visible(true)
		animation.play("seta_animacao")

func _on_area_2d_body_entered(body):
		get_tree().change_scene_to_file("res://menu_final.tscn")


func _on_life_morreu():
	PlayerMorreu = true
	animation.play("Reiniciar_animacao")



