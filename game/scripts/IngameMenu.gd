extends CanvasLayer

signal quit

func _ready():
	$VBoxContainer.visible = false

func toggle_visibility():
	$VBoxContainer.visible = !$VBoxContainer.visible

func _on_Button_Continue_pressed():
	$VBoxContainer.visible = false

func _on_Button_Abort_pressed():
	emit_signal("quit")
