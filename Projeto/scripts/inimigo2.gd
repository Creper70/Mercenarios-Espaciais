extends CharacterBody2D


var _player_ref = "oi"
var speed = 250
var accel = 7
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@export_category("Objects")
@export var _texture: Sprite2D = null
@export var _animation: AnimationPlayer = null
@export var seguir = self.position
@onready var c = get_parent().get_parent()
@onready var spawn = [get_parent().get_node("spawn1"),
get_parent().get_node("spawn2")]
@onready var spawn_final = get_parent().get_node("spawn1")
@onready var explosaoSom = $explosaoSom
@onready var HitSom = $HitSom
var detector = true
var vida: int = 3
var matou: int = 0
var levou_dano = false
var rng = RandomNumberGenerator.new()
var pitchRand

func _ready():
	$explosao.set_visible(false)
	escolher_spawn()
	

func escolher_spawn() -> void:
	if Global.rounds_Global < 4:
		var spawner_index = randi() % spawn.size()
		set_position(spawn[spawner_index].global_position)
	elif Global.rounds_Global == 4:
		speed = 320
		var spawner_index = spawn_final
		set_position(spawn_final.global_position)

func _on_detection_area_body_entered(_body) -> void:
	if _body.is_in_group("character"):
		_player_ref = _body

func _on_detection_area_body_exited(_body):
	if _body.is_in_group("character"):
		pass
	
func _on_hurt_box_area_entered(area):
	if area.is_in_group("ProjetilPlayer"):
		levou_dano = true
		area.get_parent().queue_free()
		vida -= 1
		if vida == 0:
			som()
			levou_dano = false
			c.adicionar_morte()
			speed = 0
			self.velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if detector:
		c.mudar()

	var player_pos = c.mudar()
	var direction = Vector3()
	_animate()
	
	if player_pos == null:
		_player_ref = null
		return
	nav.target_position = player_pos

	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	move_and_slide()

func dano():
	levou_dano = false

func hit():
	HitSom.play()

func som():
	pitchRand = rng.randf_range(0.70, 1.30)
	explosaoSom.set_pitch_scale(pitchRand)
	explosaoSom.play()
	pass

func _animate() -> void:
	if velocity.x > 0:
		_texture.flip_h = false
		
	if velocity.x < 0:
		_texture.flip_h = true

	if _player_ref == null:
		return
	
	if levou_dano:
		_animation.play("Hit_flash")
	
	if speed == 250 and levou_dano == false || speed == 320 and levou_dano == false:
		_animation.play("walk")
		
	if speed == 0 and vida == 0:
		$Texture.set_visible(false)
		$HurtBox.set_monitoring(false)
		$Collision.set_disabled(true)
		_animation.play("death")
		matou += 1
		await get_tree().create_timer(0.4).timeout
		queue_free()








