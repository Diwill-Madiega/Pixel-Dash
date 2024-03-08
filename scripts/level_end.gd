extends Area2D

var player:CharacterBody2D
var fade_screen

func _ready():
	player = get_node("../../Player")
	fade_screen = get_node("../../Player/Node/Camera2D/FadeScreen/Rect/AnimationPlayer")

func _on_body_entered(body):
	if body.is_in_group("player"):
		player.save_level_completion()
		player.level_finished = true
		await get_tree().create_timer(0.5).timeout
		fade_screen.play("fade_to_black")
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://menus/level_select.tscn")
