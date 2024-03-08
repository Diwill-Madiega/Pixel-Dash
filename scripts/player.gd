extends CharacterBody2D

const SPEED = 125.0
const CUBE_VELOCITY = -220.0
const SHIP_VELOCITY = -17.0
const UFO_VELOCITY = -160.0

var sprite
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var rotation_speed = 0.5
var inverted_gravity:bool = false
var is_ship:bool = false
var is_ufo:bool = false
var is_ball:bool = false
var is_cube:bool = true
var dead:bool = false
var level_finished:bool = false

var save:SaveManager = SaveManager.new()
var progress_bar:ProgressBar

var player_icon

func _ready():
	save.load_game()
	sprite = $Sprite
	progress_bar = $Node/Camera2D/LevelCompletion/ProgressBar
	$Node/Camera2D/LevelCompletion.player = self
	$DeathSound.volume_db = GameState.sfx_value
	get_node("../Attempt").text = "Attempt " + str(GameState.current_attempt)
	
	if GameState.player_icon == 1 : 
		player_icon = load("res://sprites/player_icons/icon_1.png")
	elif GameState.player_icon == 2 : 
		player_icon = load("res://sprites/player_icons/icon_2.png")
	elif GameState.player_icon == 3 : 
		player_icon = load("res://sprites/player_icons/icon_3.png")
	elif GameState.player_icon == 4 : 
		player_icon = load("res://sprites/player_icons/icon_4.png")
	elif GameState.player_icon == 5 : 
		player_icon = load("res://sprites/player_icons/icon_5.png")
	elif GameState.player_icon == 6 : 
		player_icon = load("res://sprites/player_icons/icon_6.png")
		
	sprite.texture = player_icon
	sprite.modulate = (GameState.player_color)

func _physics_process(delta):
	
	if level_finished:
		velocity.x = 100
	
	if not dead and not level_finished:	
		if not is_on_floor() and not inverted_gravity:
			if (is_cube):
				sprite.rotate(0.15)
				velocity.y += gravity * delta
			else:
				velocity.y += gravity/2 * delta
		elif not is_on_ceiling() and inverted_gravity:
			if (is_cube):
				sprite.rotate(-0.15)
				velocity.y -= gravity * delta
			else:
				velocity.y -= gravity/2 * delta
		elif is_ball == false:
			sprite.rotation = lerp_angle(rotation,0,10)
		
		if (is_cube):
			if Input.is_action_pressed("ui_accept") and is_on_floor() and not inverted_gravity:
				velocity.y = CUBE_VELOCITY
			elif Input.is_action_pressed("ui_accept") and is_on_ceiling() and inverted_gravity:
				velocity.y = -CUBE_VELOCITY
		elif (is_ship):
			if Input.is_action_pressed("ui_accept") and not inverted_gravity:
				velocity.y += SHIP_VELOCITY
			elif Input.is_action_pressed("ui_accept") and inverted_gravity:
				velocity.y -= SHIP_VELOCITY			
		elif (is_ufo):
			if Input.is_action_just_pressed("ui_accept") and not inverted_gravity:
				velocity.y = UFO_VELOCITY
			elif Input.is_action_just_pressed("ui_accept") and inverted_gravity:
				velocity.y = -UFO_VELOCITY
		elif (is_ball) and Input.is_action_just_pressed("ui_accept"):
			if is_on_floor() and inverted_gravity == false:
				hit_jump_pad(400)
				switch_gravity(true)
			elif is_on_ceiling() and inverted_gravity == true:
				hit_jump_pad(400)
				switch_gravity(false)

		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		if Input.is_action_just_pressed("ui_left") and is_ship:
				sprite.scale.x = -1
		elif Input.is_action_just_pressed("ui_right") and is_ship:
				sprite.scale.x = 1
				
		if Input.is_action_pressed("ui_left") and is_ball:
			if inverted_gravity : sprite.rotate(0.15)
			else : sprite.rotate(-0.15)
		elif Input.is_action_pressed("ui_right") and is_ball:
			if inverted_gravity : sprite.rotate(-0.15)
			else : sprite.rotate(0.15)
			
		if is_ship:
			if (sprite.scale.x == -1 and inverted_gravity) or (sprite.scale.x == 1 and not inverted_gravity):
				if Input.is_action_pressed("ui_accept") and sprite.rotation > -0.75:
					sprite.rotate(-0.03)
				elif sprite.rotation < 0.75:
					sprite.rotate(0.03)
			elif (sprite.scale.x == 1 and inverted_gravity) or (sprite.scale.x == -1 and not inverted_gravity):
				if Input.is_action_pressed("ui_accept") and sprite.rotation < 0.75:
					sprite.rotate(0.03)
				elif sprite.rotation > -0.75:
					sprite.rotate(-0.03)
		
		move_and_slide()

func lerp_angle(from, to, weight):
	return from + short_angle_dist(from, to) * weight

func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference
	
func hit_jump_pad(jump_power:float):
	if inverted_gravity:
		velocity.y = -jump_power
	else:
		velocity.y = jump_power
	
func switch_gravity(inverted:bool):
	inverted_gravity = inverted
	if inverted_gravity == true:
		sprite.scale.y = -1
	else:
		sprite.scale.y = 1
	
func enter_portal(portal_type:String):
	if portal_type == "ship":
		sprite.texture = load("res://sprites/player/player_ship.png")
		is_cube = false
		is_ship = true
		is_ufo = false
		is_ball = false
		
	elif portal_type == "ufo":
		sprite.texture = load("res://sprites/player/player_ufo.png")
		is_cube = false
		is_ship = false
		is_ufo = true
		is_ball = false
		
	elif portal_type == "ball":
		sprite.texture = load("res://sprites/player/player_ball.png")
		is_cube = false
		is_ship = false
		is_ufo = false
		is_ball = true
		
	elif portal_type == "cube":
		sprite.texture = player_icon
		is_cube = true
		is_ship = false
		is_ufo = false
		is_ball = false	
		
func die():
	if sprite != null:
		sprite.queue_free()
	$DeathParticles.emitting = true
	dead = true
	GameState.current_attempt+=1
	get_node("../Theme").stop()
	$DeathSound.play()
	await get_tree().create_timer(0.5).timeout
	$Node/Camera2D/FadeScreen/Rect/AnimationPlayer.play("fade_to_black")
	await get_tree().create_timer(0.5).timeout
	save_level_completion()
	get_tree().reload_current_scene()

func save_level_completion():

	if get_tree().get_current_scene().get_name() == "level_1" and GameState.level_1_completion < progress_bar.value:
		GameState.level_1_completion = progress_bar.value
	elif get_tree().get_current_scene().get_name() == "level_2" and GameState.level_2_completion < progress_bar.value:
		GameState.level_2_completion = progress_bar.value
	elif get_tree().get_current_scene().get_name() == "level_3" and GameState.level_3_completion < progress_bar.value:
		GameState.level_3_completion = progress_bar.value
	elif get_tree().get_current_scene().get_name() == "level_4" and GameState.level_4_completion < progress_bar.value:
		GameState.level_4_completion = progress_bar.value
	elif get_tree().get_current_scene().get_name() == "level_5" and GameState.level_5_completion < progress_bar.value:
		GameState.level_5_completion = progress_bar.value
		print(GameState.level_5_completion)
		
	if get_node("../").got_coin and not dead and GameState.current_level==1 : GameState.coin_1_obtained = true
	elif get_node("../").got_coin and not dead and GameState.current_level==2 : GameState.coin_2_obtained = true
	elif get_node("../").got_coin and not dead and GameState.current_level==3 : GameState.coin_3_obtained = true
	elif get_node("../").got_coin and not dead and GameState.current_level==4 : GameState.coin_4_obtained = true
	elif get_node("../").got_coin and not dead and GameState.current_level==5 : GameState.coin_5_obtained = true
	
	if (not dead):
		GameState.current_attempt = 1
		
	save.save_game()
	
