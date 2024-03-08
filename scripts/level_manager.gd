extends Node2D

@export var pauseUI:CanvasItem

var level_completion
var save:SaveManager = SaveManager.new()
var got_coin:bool
var cut_location
var base_music_value = -15

# Called when the node enters the scene tree for the first time.
func _ready():
	pauseUI = get_node("Player/Node/Camera2D/PauseUI")
	$Theme.volume_db = base_music_value + GameState.music_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("pause") and not $Player.level_finished:
		if not get_tree().paused:
			pauseUI.visible = true
			pauseUI.current_select = 2
			#get_node("Player/Node/Camera2D/PauseUI/ButtonResume").grab_focus()
			get_tree().paused = true
			cut_location = $Theme.get_playback_position()
			$Theme.stop()
		else:
			get_tree().paused = false
			pauseUI.visible = false
			$Theme.play()
			$Theme.seek(cut_location)
