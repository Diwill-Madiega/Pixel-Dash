extends Camera2D

var player
var level_end:Node2D
var follow_speed = 150

func _ready():
	player = get_node("../../")
	level_end = get_node("../../../LevelEnd")
	position.y = player.position.y - 20

func _physics_process(delta):
	if player.position.x < level_end.position.x - 120 and player.position.x > 130:
		position.x = player.position.x
		
	if player.position.y < 60 and position.y > player.position.y + 60:
		position.y -= follow_speed * delta
	elif player.position.y > 70 and position.y < player.position.y - 25:
		position.y += follow_speed * delta
