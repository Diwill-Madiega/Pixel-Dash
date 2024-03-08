extends Node2D

var level:Node2D

func _ready():
	level = get_node("../../")
	$AudioStreamPlayer2D.volume_db = GameState.sfx_value
	
	if get_tree().get_current_scene().get_name() == "level_1" and GameState.coin_1_obtained:
		$AnimatedSprite2D.play("obtained")
	elif get_tree().get_current_scene().get_name() == "level_2" and GameState.coin_2_obtained:
		$AnimatedSprite2D.play("obtained")
	elif get_tree().get_current_scene().get_name() == "level_3" and GameState.coin_3_obtained:
		$AnimatedSprite2D.play("obtained")
	elif get_tree().get_current_scene().get_name() == "level_4" and GameState.coin_4_obtained:
		$AnimatedSprite2D.play("obtained")
	elif get_tree().get_current_scene().get_name() == "level_5" and GameState.coin_5_obtained:
		$AnimatedSprite2D.play("obtained")
	else:
		$AnimatedSprite2D.play("idle")
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and not level.got_coin:
		$AudioStreamPlayer2D.play()
		$AnimationPlayer.play("obtained")
		level.got_coin = true
