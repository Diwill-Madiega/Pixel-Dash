extends Node2D

var player:CharacterBody2D
var playerNear:bool = false
var anim:AnimatedSprite2D

func _ready():
	set_process_input(true)
	player = get_node("../../Player")
	anim = $AnimatedSprite2D
	anim.play("idle")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and playerNear:
		player.hit_jump_pad(-240)
		anim.play("hit")

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		playerNear = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		playerNear = false

func _on_animated_sprite_2d_animation_looped():
		anim.play("idle")
