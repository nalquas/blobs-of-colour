extends KinematicBody2D

export (float) var speed = 120.0
export (String) var colour = "green"
export (PackedScene) var scene_blob

var blobs = []
var min_int = -9223372036854775808 #-2^63

func _ready():
	# Spawn the first blob
	for _i in range(0, 3):
		spawn_blob()
	
	# Make the laser circle appear below all other objects
	$AnimatedSprite_Circle.z_as_relative = false
	$AnimatedSprite_Circle.z_index = min_int
	
	# Start animations
	$AnimatedSprite_Laser.play()
	$AnimatedSprite_Circle.play()

func _physics_process(_delta):
	# Handle player movement
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
	
	# Handle blob positions
	for i in range(0, blobs.size()):
		var index_factor = i / float(blobs.size())
		var time_offset = OS.get_ticks_msec() / 1000.0
		blobs[i].position = Vector2(
			64.0 * cos(index_factor * 2*PI + time_offset),
			64.0 * sin(index_factor * 2*PI + time_offset) + 1
		)

func spawn_blob():
	# Prepare blob
	var blob = scene_blob.instance()
	blob.colour = colour
	blob.position = Vector2(-2048, -2048)
	
	# Spawn blob
	blobs.append(blob)
	call_deferred("add_child", blob)
