extends Control

var save:SaveManager = SaveManager.new()
var rng = RandomNumberGenerator.new()
var current_select = 2

func _ready():
	save.load_game()
	GameState.current_attempt = 1
	save.save_game()
	$AudioStreamPlayer2D.volume_db = GameState.sfx_value
	$Background.modulate = Color(rng.randf_range(0.0,1.0), rng.randf_range(0.0,1.0), rng.randf_range(0.0,1.0))
	
	$PlayButton.grab_focus()

func _process(delta):
	
	if (current_select==1):
		$IconsButton.grab_focus()
	elif (current_select==2):
		$PlayButton.grab_focus()
	elif (current_select==3):
		$OptionsButton.grab_focus()
	
	if Input.is_action_just_pressed("ui_right"):
		if current_select == 3:
			current_select = 1
		else :current_select+=1
	elif Input.is_action_just_pressed("ui_left"):
		if current_select == 1:
			current_select = 3
		else :current_select-=1
		
	if Input.is_action_just_pressed("pause"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("reset"):
		GameState.level_1_completion = 0
		GameState.level_2_completion = 0
		GameState.level_3_completion = 0
		GameState.level_4_completion = 0
		GameState.level_5_completion = 0
		
		GameState.coin_1_obtained = false
		GameState.coin_2_obtained = false
		GameState.coin_3_obtained = false
		GameState.coin_4_obtained = false
		GameState.coin_5_obtained = false
		
		GameState.player_icon = 1
		GameState.player_color = "white"
		
		GameState.music_value = 0
		GameState.sfx_value = 0
		
		save.save_game()

func _on_play_button_pressed():
	$AudioStreamPlayer2D.play()
	$FadeScreen/Rect/AnimationPlayer.play("fade_to_black")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://menus/level_select.tscn")

func _on_icons_button_pressed():
	$AudioStreamPlayer2D.play()
	$FadeScreen/Rect/AnimationPlayer.play("fade_to_black")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://menus/icon_editor.tscn")


func _on_options_button_pressed():
	$AudioStreamPlayer2D.play()
	$FadeScreen/Rect/AnimationPlayer.play("fade_to_black")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://menus/options.tscn")
