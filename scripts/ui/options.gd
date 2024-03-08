extends Control

var save:SaveManager = SaveManager.new()
var current_selected_scrollbar

func _ready():
	$MusicModifier.value = (GameState.music_value * 2 + 50)
	$SFXModifier.value = (GameState.sfx_value * 2 + 50)	
	select_up()
	
func _process(delta):
	if Input.is_action_pressed("pause"):
		_on_back_button_pressed()
		
	if Input.is_action_pressed("ui_up"):
		select_up()
	if Input.is_action_pressed("ui_down"):
		select_down()
		
	if Input.is_action_pressed("ui_right"):
		current_selected_scrollbar.value += delta * 30
	if Input.is_action_pressed("ui_left"):
		current_selected_scrollbar.value -= delta * 30

func _on_back_button_pressed():
	$FadeScreen/Rect/AnimationPlayer.play("fade_to_black")
	await get_tree().create_timer(0.5).timeout
	
	GameState.music_value = ($MusicModifier.value - 50) / 2
	GameState.sfx_value = ($SFXModifier.value - 50) / 2
	
	save.save_game()
	get_tree().change_scene_to_file("res://menus/title_screen.tscn")
	
func select_up():
	current_selected_scrollbar = $MusicModifier
	$Music.modulate = Color(0, 1, 1)
	$SFX.modulate = Color(1, 1, 1)

func select_down():
	current_selected_scrollbar = $SFXModifier
	$Music.modulate = Color(1, 1, 1)
	$SFX.modulate = Color(0, 1, 1)
