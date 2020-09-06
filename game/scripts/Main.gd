extends Node

export (PackedScene) var scene_game
export (PackedScene) var scene_gameover_menu

var min_int = -9223372036854775808 #-2^63
var highscore = 0

func _ready():
	# Load game
	var new_game_instance = scene_game.instance()
	new_game_instance.name = "Game"
	new_game_instance.paused = true
	call_deferred("add_child", new_game_instance)
	
	# Load highscore
	load_highscore()

func save_highscore():
	var file = File.new()
	file.open("user://highscore.dat", file.WRITE)
	print("Storing string \"" + String(int(highscore)) + "\"")
	file.store_string(String(int(highscore)))
	file.close()

func load_highscore():
	var file = File.new()
	file.open("user://highscore.dat", file.READ)
	var content = file.get_as_text()
	file.close()
	print("Loaded string \"" + String(content) + "\"")
	highscore = int(content)
	$MainMenu.set_highscore(highscore)

func pause_game(state):
	for node in get_tree().get_nodes_in_group("pausable"):
		node.paused = state

func _on_Game_quit():
	# Show main menu
	$MainMenu.offset = Vector2(0, 0)
	
	# Reload game
	$Game.reset()

func _on_Game_gameover(score):
	# Pause game
	pause_game(true)
	$Game.switch_camera_to_player(false) # Show overview camera
	
	# Load gameover menu
	var new_gameover_menu_instance = scene_gameover_menu.instance()
	new_gameover_menu_instance.name = "GameOverMenu"
	new_gameover_menu_instance.setScore(score, highscore)
	call_deferred("add_child", new_gameover_menu_instance)
	
	# New highscore? Overwrite save.
	if score*100 > highscore:
		highscore = score*100
		save_highscore()
		load_highscore()

func _on_GameOverMenu_finished():
	# Reset game
	$Game.reset()
	
	# Show main menu
	$MainMenu.offset = Vector2(0, 0)

func _on_MainMenu_newgame():
	# Hide main menu
	$MainMenu.offset = Vector2(-min_int, -min_int) # can't hide CanvasLayer, so let's just move it very far away
	
	# Switch camera to player
	$Game.switch_camera_to_player(true)
	
	# Unpause game
	pause_game(false)

func _on_MainMenu_quit():
	# Quit application
	get_tree().quit()
