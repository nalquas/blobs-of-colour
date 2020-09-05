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
	
	# Handle scoring
	var total = float(80*45)
	
	var green = 0
	var blue = 0
	var orange = 0
	var pink = 0
	for x in range(0, 80):
		for y in range(0, 45):
			var index = $PaintMap.get_cell(x, y)
			match index:
				0:
					green += 1
				1:
					blue += 1
				2:
					orange += 1
				3:
					pink += 1
	$GameOverlay/PieChart.setColours(green / total, blue / total, orange / total, pink / total)
	$GameOverlay/PieChart.update()

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
