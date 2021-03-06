extends CanvasLayer

signal newgame
signal quit

func _ready():
	connect("newgame", get_parent(), "_on_MainMenu_newgame")
	connect("quit", get_parent(), "_on_MainMenu_quit")

func set_highscore(highscore):
	$Label_Highscore.text = "Highscore: " + String(int(highscore)) + "%"

func _on_Button_Start_pressed():
	emit_signal("newgame")

func _on_Button_Quit_pressed():
	emit_signal("quit")
