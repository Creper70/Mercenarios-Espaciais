extends Control

@onready var rondas = $Rondas
@onready var tempo = $Tempo
@onready var preparo = $Inicial
@onready var playground = get_parent()


func _ready():
	preparo.set_visible(true)
	tempo.set_visible(false)
	rondas.set_visible(false)
	preparo.text = str("Preparado?")

func _physics_process(delta):
	var temporizador: int = playground.cooldown.time_left
	rondas.text = str("Rodada ", playground.rounds + 1)
	tempo.text = str(temporizador)
