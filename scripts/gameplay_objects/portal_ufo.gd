extends Node2D

var player:CharacterBody2D

func _ready():
	player = get_node("../../Player")

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player.enter_portal("ufo")
