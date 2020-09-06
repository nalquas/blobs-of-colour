extends Node

export (PackedScene) var scene_menu
export (PackedScene) var scene_game
export (PackedScene) var scene_gameover_menu

var min_int = -9223372036854775808 #-2^63

func _ready():
	# Load main menu
	var new_menu_instance = scene_menu.instance()
	new_menu_instance.name = "MainMenu"
	call_deferred("add_child", new_menu_instance)
	
	load_game()

func load_game():
	# Load game
	var new_game_instance = scene_game.instance()
	new_game_instance.name = "Game"
	new_game_instance.paused = true
	call_deferred("add_child", new_game_instance)

func pause_game(state):
	for node in get_tree().get_nodes_in_group("pausable"):
		node.paused = state

func _on_Game_quit():
	# Show main menu
	$MainMenu.offset = Vector2(0, 0)
	
	# Reload game
	load_game()

func _on_Game_gameover(score):
	# Pause game
	pause_game(true)
	$Game.switch_camera_to_player(false) # Show overview camera
	
	# Load gameover menu
	var new_gameover_menu_instance = scene_gameover_menu.instance()
	new_gameover_menu_instance.name = "GameOverMenu"
	new_gameover_menu_instance.setScore(score, 73.0)
	call_deferred("add_child", new_gameover_menu_instance)

func _on_GameOverMenu_finished():
	# End game
	get_tree().get_nodes_in_group("game")[0].queue_free()
	
	# Reload game
	load_game()
	
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
