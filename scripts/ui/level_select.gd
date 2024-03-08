extends Control

var button_left:Button
var button_right:Button
var levels:Control

var levels_moving_right:bool = false
var levels_moving_left:bool = false

var current_selected_level:int = 1

var target_position:float
var save:SaveManager = SaveManager.new()

func _ready():
	
	get_tree().paused = false
	save.load_game()
	button_left = $ButtonLeft
	button_right = $ButtonRight
	levels = $Levels
	$AudioStreamPlayer2D.volume_db = GameState.sfx_value

	$Levels/Level1/ProgressBar.value = GameState.level_1_completion
	$Levels/Level2/ProgressBar.value = GameState.level_2_completion
	$Levels/Level3/ProgressBar.value = GameState.level_3_completion
	$Levels/Level4/ProgressBar.value = GameState.level_4_completion
	$Levels/Level5/ProgressBar.value = GameState.level_5_completion
	
	if GameState.coin_1_obtained:
		$Levels/Level1/Coin.texture = load("res://sprites/coin/normal/coin.png")
	else: $Levels/Level1/Coin.texture = load("res://sprites/coin/dark/coin_dark.png")
		
	if GameState.coin_2_obtained:
		$Levels/Level2/Coin.texture = load("res://sprites/coin/normal/coin.png")
	else: $Levels/Level2/Coin.texture = load("res://sprites/coin/dark/coin_dark.png")
		
	if GameState.coin_3_obtained:
		$Levels/Level3/Coin.texture = load("res://sprites/coin/normal/coin.png")
	else: $Levels/Level3/Coin.texture = load("res://sprites/coin/dark/coin_dark.png")
	
	if GameState.coin_4_obtained:
		$Levels/Level4/Coin.texture = load("res://sprites/coin/normal/coin.png")
	else: $Levels/Level4/Coin.texture = load("res://sprites/coin/dark/coin_dark.png")
	
	if GameState.coin_5_obtained:
		$Levels/Level5/Coin.texture = load("res://sprites/coin/normal/coin.png")
	else: $Levels/Level5/Coin.texture = load("res://sprites/coin/dark/coin_dark.png")
	
	current_selected_level = GameState.current_level
	reach_selected_level()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_on_button_pressed()
		
	if Input.is_action_pressed("pause"):
		_on_back_button_pressed()
		
	if Input.is_action_just_pressed("ui_left") and not button_left.disabled:
		_on_button_left_pressed()
		
	if Input.is_action_just_pressed("ui_right") and not button_right.disabled:
		_on_button_right_pressed()
		
	if current_selected_level==1:
		button_left.disabled = true
	else:
		button_left.disabled = false
		
	if current_selected_level==5:
		button_right.disabled = true
	else:
		button_right.disabled = false
		
	if (levels_moving_right):
		levels.position = levels.position.move_toward(Vector2(target_position,levels.position.y), delta * 1600)
	elif (levels_moving_left):
		levels.position = levels.position.move_toward(Vector2(target_position,levels.position.y), delta * 1600)
		
	if current_selected_level==1:
		$Background.modulate = "blue"
	elif current_selected_level==2:
		$Background.modulate = "green"
	elif current_selected_level==3:
		$Background.modulate = "yellow"
	elif current_selected_level==4:
		$Background.modulate = "red"
	elif current_selected_level==5:
		$Background.modulate = "purple"
		
func _on_button_left_pressed():
	if not levels_moving_left and not levels_moving_right:
		levels_moving_left = true
		target_position = levels.position.x+320
		await get_tree().create_timer(0.25).timeout
		levels_moving_left = false
		current_selected_level-=1
		$ButtonLeft.release_focus()

func _on_button_right_pressed():
	if not levels_moving_left and not levels_moving_right:
		levels_moving_right = true
		target_position = levels.position.x-320
		await get_tree().create_timer(0.25).timeout
		levels_moving_right = false
		current_selected_level+=1
		$ButtonRight.release_focus()

func reach_selected_level():
	for i in current_selected_level-1:
		levels.position.x-=320


func _on_button_pressed():
		GameState.current_level = current_selected_level
		$AudioStreamPlayer2D.play()
		$FadeScreen/Rect/AnimationPlayer.play("fade_to_black")
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://levels/level_"+str(current_selected_level)+".tscn")


func _on_back_button_pressed():
	$FadeScreen/Rect/AnimationPlayer.play("fade_to_black")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://menus/title_screen.tscn")
