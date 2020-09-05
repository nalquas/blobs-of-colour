extends Node

export (PackedScene) var scene_menu
export (PackedScene) var scene_game

var min_int = -9223372036854775808 #-2^63

func _ready():
	load_MainMenu()

func load_MainMenu():
	# Load main menu
	var new_menu_instance = scene_menu.instance()
	new_menu_instance.name = "MainMenu"
	call_deferred("add_child", new_menu_instance)

func _on_Game_quit():
	# Show main menu
	$MainMenu.offset = Vector2(0, 0)

func _on_MainMenu_newgame():
	# Hide main menu
	$MainMenu.offset = Vector2(-min_int, -min_int)
	
	# Load game
	var new_game_instance = scene_game.instance()
	new_game_instance.name = "Game"
	call_deferred("add_child", new_game_instance)

func _on_MainMenu_quit():
	get_tree().quit()
