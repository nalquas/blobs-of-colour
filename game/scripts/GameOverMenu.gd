extends CanvasLayer

signal finished

export (float) var gameover_time = 8.0

var time_remaining = gameover_time

func _ready():
	connect("finished", get_parent(), "_on_GameOverMenu_finished")

func _process(delta):
	# Handle resizing of "remaining time progress bar"
	$ProgressRect.margin_left = - get_viewport().size.x / 2
	$ProgressRect.margin_right = - get_viewport().size.x / 2 + get_viewport().size.x * (time_remaining / gameover_time)
	
	# Handle time
	time_remaining -= delta
	if time_remaining <= 0:
		emit_signal("finished")
		queue_free()

func setVictory(state):
	if state:
		$Label_Message.text = "Victory"
	else:
		$Label_Message.text = "Game Over"

func setScore(score, highscore):
	$Label_Score.text = "Area filled: " + String(int(score*100)) + "%\nHighscore : " + String(int(highscore)) + "%"
	if score > highscore:
		$Label_Score.text += " (Old!)"
