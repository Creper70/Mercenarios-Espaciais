extends Control

@onready var animation = $AnimationPlayer
@onready var botao = $TextureButton


func _ready():
	botao.set_visible(false)
	animation.play("H_fade_in_out")
	

func obrigado():
	animation.play("O_fade_in_out")


func brota_botao():
	botao.set_visible(true)


func _on_texture_button_pressed():
	get_tree().quit()
