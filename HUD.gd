extends CanvasLayer

@onready var hp = 5
@onready var vida = $Label

signal hp_changed
signal died


func take_damage(dmg):
	set_hp(hp - dmg)

func set_hp( new_hp ):
	emit_signal("hp_changed", new_hp)
	hp = new_hp
	vida.set_text("vida: ", hp)
	if hp <= 0:
		die()


func die():
	emit_signal("died")
	queue_free()


func _on_ronaldo_perna_de_elefante_life_changed(player_hearts):
	$Life/Sprite2D.set_frame(hp-1)
