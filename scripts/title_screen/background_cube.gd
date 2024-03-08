extends CharacterBody2D

var SPEED = 120
const JUMP_VELOCITY = -250.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var rng = RandomNumberGenerator.new()

func _ready():
	_jump()
	_reset()

func _physics_process(delta):
	velocity.x = SPEED
	
	if not is_on_floor():
		$Sprite.rotate(0.15)
		velocity.y += gravity * delta
	else:
		$Sprite.rotation = lerp_angle(rotation,0,10)	
		
	if (position.x >350):
		_reset()
	move_and_slide()
	
func _reset():
	
	var random_icon = rng.randi_range(0,6)
	
	if random_icon == 1:
		$Sprite.texture = load("res://sprites/player_icons/icon_1.png")
	elif random_icon == 2:
		$Sprite.texture = load("res://sprites/player_icons/icon_2.png")
	elif random_icon == 3:
		$Sprite.texture = load("res://sprites/player_icons/icon_3.png")
	elif random_icon == 4:
		$Sprite.texture = load("res://sprites/player_icons/icon_4.png")
	elif random_icon == 5:
		$Sprite.texture = load("res://sprites/player_icons/icon_5.png")
	elif random_icon == 6:
		$Sprite.texture = load("res://sprites/player_icons/icon_6.png")
		
	$Sprite.modulate = Color(rng.randf_range(0.0,1.0), rng.randf_range(0.0,1.0), rng.randf_range(0.0,1.0))
	position.x = -50
	SPEED = rng.randf_range(120,320)
	
func _jump():
	await get_tree().create_timer(rng.randf_range(0.4,1.6)).timeout
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	_jump()
