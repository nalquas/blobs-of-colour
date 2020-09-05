extends KinematicBody2D

export (float) var speed = 150.0

func _ready():
	# Make the laser circle appear below all other objects
	$AnimatedSprite_Circle.z_as_relative = false
	$AnimatedSprite_Circle.z_index = -9223372036854775808 #-2^63
	
	# Start animations
	$AnimatedSprite_Laser.play()
	$AnimatedSprite_Circle.play()

func _physics_process(_delta):
	# Handle movement
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
