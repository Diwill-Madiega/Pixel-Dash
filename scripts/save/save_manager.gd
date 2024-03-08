class_name SaveManager extends Object

const default_filename= "save"

func _build():
	return {
		"level_1_completion" : GameState.level_1_completion,
		"level_2_completion" : GameState.level_2_completion,
		"level_3_completion" : GameState.level_3_completion,
		"level_4_completion" : GameState.level_4_completion,
		"level_5_completion" : GameState.level_5_completion,
		
		"coin_1_obtained" : GameState.coin_1_obtained,
		"coin_2_obtained" : GameState.coin_2_obtained,
		"coin_3_obtained" : GameState.coin_3_obtained,
		"coin_4_obtained" : GameState.coin_4_obtained,
		"coin_5_obtained" : GameState.coin_5_obtained,
		
		"player_icon" : GameState.player_icon,
		"player_color" : GameState.player_color,
		
		"current_attempt" : GameState.current_attempt,
		
		"music_value" : GameState.music_value,
		"sfx_value" : GameState.sfx_value,
	}
	
func save_game():
	var savegame = FileAccess.open(default_filename, FileAccess.WRITE)
	if (savegame != null):
		savegame.store_line(JSON.stringify(_build()))
	
func load_game():
	var savegame = FileAccess.open(default_filename, FileAccess.READ)
	if (savegame != null):
		var json:JSON = JSON.new()
		var parse_result = json.parse(savegame.get_line())
		if not (parse_result == OK):
			return
		var data:Dictionary = json.get_data()
		GameState.level_1_completion = data.get("level_1_completion", GameState.level_1_completion)
		GameState.level_2_completion = data.get("level_2_completion", GameState.level_2_completion)
		GameState.level_3_completion = data.get("level_3_completion", GameState.level_3_completion)
		GameState.level_4_completion = data.get("level_4_completion", GameState.level_4_completion)
		GameState.level_5_completion = data.get("level_5_completion", GameState.level_5_completion)
		
		GameState.coin_1_obtained = data.get("coin_1_obtained", GameState.coin_1_obtained)
		GameState.coin_2_obtained = data.get("coin_2_obtained", GameState.coin_2_obtained)
		GameState.coin_3_obtained = data.get("coin_3_obtained", GameState.coin_3_obtained)
		GameState.coin_4_obtained = data.get("coin_4_obtained", GameState.coin_4_obtained)
		GameState.coin_5_obtained = data.get("coin_5_obtained", GameState.coin_5_obtained)
		
		GameState.player_icon = data.get("player_icon", GameState.player_icon)
		GameState.player_color = data.get("player_color", GameState.player_color)
		
		GameState.current_attempt = data.get("current_attempt", GameState.current_attempt)
		
		GameState.music_value = data.get("music_value", GameState.music_value)
		GameState.sfx_value = data.get("sfx_value", GameState.sfx_value)
