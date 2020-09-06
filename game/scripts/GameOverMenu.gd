extends CanvasLayer

signal finished

var time_remaining = 8.0

func _ready():
	connect("finished", get_parent(), "_on_GameOverMenu_finished")

func _process(delta):
	# Handle resizing of "remaining time progress bar"
	$ProgressRect.margin_left = - get_viewport().size.x / 2
	$ProgressRect.margin_right = - get_viewport().size.x / 2 + get_viewport().size.x * (time_remaining / 5.0)
	
	# Handle time
	time_remaining -= delta
	if time_remaining <= 0:
		emit_signal("finished")
		queue_free()

func setScore(score, highscore):
	if score > highscore:
		$Label_Message.text = "Victory"
	else:
		$Label_Message.text = "Game Over"
	$Label_Score.text = "Area filled: " + String(int(score*100)) + "%\nHighscore : " + String(int(highscore)) + "%"
