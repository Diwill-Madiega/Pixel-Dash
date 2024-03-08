extends Control

var save:SaveManager = SaveManager.new()

func _ready():
	$Icons/Icon1.grab_focus()
	
	if GameState.player_icon == 1 : 
		$PlayerPreview.texture = load("res://sprites/player_icons/icon_1.png")
	elif GameState.player_icon == 2 : 
		$PlayerPreview.texture = load("res://sprites/player_icons/icon_2.png")
	elif GameState.player_icon == 3 : 
		$PlayerPreview.texture = load("res://sprites/player_icons/icon_3.png")
	elif GameState.player_icon == 4 : 
		$PlayerPreview.texture = load("res://sprites/player_icons/icon_4.png")
	elif GameState.player_icon == 5 : 
		$PlayerPreview.texture = load("res://sprites/player_icons/icon_5.png")
	elif GameState.player_icon == 6 : 
		$PlayerPreview.texture = load("res://sprites/player_icons/icon_6.png")
		
	$PlayerPreview.modulate = (GameState.player_color)


func _process(delta):
	if Input.is_action_pressed("pause"):
		_on_back_button_pressed()

func _on_icon_1_pressed():
	GameState.player_icon = 1
	$PlayerPreview.texture = load("res://sprites/player_icons/icon_1.png") 

func _on_icon_2_pressed():
	GameState.player_icon = 2
	$PlayerPreview.texture = load("res://sprites/player_icons/icon_2.png") 

func _on_icon_3_pressed():
	GameState.player_icon = 3
	$PlayerPreview.texture = load("res://sprites/player_icons/icon_3.png") 

func _on_icon_4_pressed():
	GameState.player_icon = 4
	$PlayerPreview.texture = load("res://sprites/player_icons/icon_4.png")

func _on_icon_5_pressed():
	GameState.player_icon = 5
	$PlayerPreview.texture = load("res://sprites/player_icons/icon_5.png")

func _on_icon_6_pressed():
	GameState.player_icon = 6
	$PlayerPreview.texture = load("res://sprites/player_icons/icon_6.png")


func _on_color_1_pressed():
	$PlayerPreview.modulate = ("blue")
	GameState.player_color = "blue"

func _on_color_2_pressed():
	$PlayerPreview.modulate = ("cyan")
	GameState.player_color = "cyan"

func _on_color_3_pressed():
	$PlayerPreview.modulate = ("green")
	GameState.player_color = "green"

func _on_color_4_pressed():
	$PlayerPreview.modulate = ("yellow")
	GameState.player_color = "yellow"

func _on_color_5_pressed():
	$PlayerPreview.modulate = ("orange")
	GameState.player_color = "orange"

func _on_color_6_pressed():
	$PlayerPreview.modulate = ("red")
	GameState.player_color = "red"

func _on_color_7_pressed():
	$PlayerPreview.modulate = ("magenta")
	GameState.player_color = "magenta"

func _on_color_8_pressed():
	$PlayerPreview.modulate = ("purple")
	GameState.player_color = "purple"

func _on_color_9_pressed():
	$PlayerPreview.modulate = ("white")
	GameState.player_color = "white"

func _on_color_10_pressed():
	$PlayerPreview.modulate = ("gray")
	GameState.player_color = "gray"

func _on_color_11_pressed():
	$PlayerPreview.modulate = ("black")
	GameState.player_color = "black"
	
	
func _on_back_button_pressed():
	save.save_game()
	$FadeScreen/Rect/AnimationPlayer.play("fade_to_black")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://menus/title_screen.tscn")
