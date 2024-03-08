extends Control

var save:SaveManager = SaveManager.new()
var current_select = 2

func _process(delta):
	if (current_select==1):
		$ButtonMenu.grab_focus()
	elif (current_select==2):
		$ButtonResume.grab_focus()
	elif (current_select==3):
		$ButtonRestart.grab_focus()
	
	if Input.is_action_just_pressed("ui_right"):
		if current_select == 3:
			current_select = 1
		else :current_select+=1
	elif Input.is_action_just_pressed("ui_left"):
		if current_select == 1:
			current_select = 3
		else :current_select-=1

func _on_button_resume_pressed():
	get_tree().paused = false
	visible = false
	get_node("../../../../Theme").play()

func _on_button_restart_pressed():
		get_tree().paused = false
		GameState.current_attempt+=1
		save.save_game()
		get_tree().reload_current_scene()

func _on_button_menu_pressed():
	GameState.current_attempt=1
	save.save_game()
	get_tree().change_scene_to_file("res://menus/level_select.tscn")
