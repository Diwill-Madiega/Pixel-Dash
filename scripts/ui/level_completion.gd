extends Control

var player:Node2D
var level_end:Node2D

func _ready():
	level_end = get_node("../../../../LevelEnd")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.value = (player.position.x / level_end.position.x) * 100
