extends Area2D

var player:Node2D

func _ready():
	player = get_node("../../../Player")

func _on_body_entered(body):
	if body.is_in_group("player") and player!=null and player.dead==false:
		player.die()
