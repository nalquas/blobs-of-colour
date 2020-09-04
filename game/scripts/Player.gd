extends KinematicBody2D

export (float) var speed = 250.0

func _physics_process(_delta):
	var direction = Vector2(0, 0)
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	move_and_slide(direction * speed)
