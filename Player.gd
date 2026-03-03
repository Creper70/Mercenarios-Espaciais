extends CharacterBody2D

signal Health(dano)

var _state_machine
var perimeter_radius:float
var comecou = false


@export_category("Variables")
@export var _move_speed: float = 300
@export var _acceleration: float = 0.4
@export var _friction: float = 0.4
@export var knockbackPower: int = 2000

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

@onready var Tiro = $Tiro
@onready var invincibility = $Invincibilityframes

const Flecha = preload("res://FlechaIrada.tscn")
const SPEED = 200.0

func _ready():
	_state_machine = _animation_tree["parameters/playback"]
	
func _process(delta):
	pass
	

func _physics_process(delta: float) -> void:
	if comecou:
		_move()
	_animate()
	move_and_slide()
	Ataque()

func _on_hurt_box_area_entered(area):
	if area.is_in_group("enemy") and invincibility.is_stopped():
		invincibility.start()
		emit_signal("Health")
		knockback(area.get_parent().velocity)


func _move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("Esquerda", "Direita"),
		Input.get_axis("Cima","Baixo")
	)
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		return
	
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)

func _animate() -> void:
	if velocity.length() > 5:
		_state_machine.travel("walk")
		return
		
	_state_machine.travel("idle")


func Ataque():
	if Input.is_action_just_pressed("Ataque") and $FireCD.is_stopped() or Input.is_action_pressed("Ataque") and $FireCD.is_stopped():
		$FireCD.start()
		Tiro.play()
		var atk = load("res://FlechaIrada.tscn").instantiate()
		var atkPosition = self.global_position.direction_to(get_global_mouse_position())
		var atkRotation = atkPosition.angle()
		get_parent().add_child(atk, true)
		atk.global_position = $Arma2D/Marker2D.global_position
		atk.rotation = atkRotation
 


func _on_timer_timeout():
	Ataque()


func _on_life_morreu():
	queue_free()

func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity -velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()


func _on_playground_comecou():
	comecou = true
