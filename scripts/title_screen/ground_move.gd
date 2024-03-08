extends Node2D

var speed:float = 200

func _process(delta):
	position.x -= speed* delta
	if position.x < -286:
		position.x = 370
