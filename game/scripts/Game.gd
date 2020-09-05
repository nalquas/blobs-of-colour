extends Node2D

signal quit

func _ready():
	connect("quit", get_parent(), "_on_Game_quit")

func _process(_delta):
	# Handle input
	if Input.is_action_just_pressed("toggle_menu"):
		$IngameMenu.toggle_visibility()
	
	# Make objects of the group "order" appear in proper draw order
	for object in get_tree().get_nodes_in_group("order"):
		object.z_index = object.position.y

func _physics_process(_delta):
	# Handle blobs painting the world (the tilemap "PaintMap")
	for blob in get_tree().get_nodes_in_group("blob"):
		var coordinates = (blob.global_position / 16.0).floor()
		var index
		match blob.colour:
			"green":
				index = 0
			"blue":
				index = 1
			"orange":
				index = 2
			"pink":
				index = 3
		$PaintMap.set_cellv(coordinates, index)
		$PaintMap.update_bitmask_area(coordinates)

func _on_IngameMenu_quit():
	emit_signal("quit")
	queue_free()
