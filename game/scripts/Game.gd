extends Node2D

signal gameover(score)
signal quit

var paused = false
var time_remaining = 10.0#99.999

func _ready():
	connect("quit", get_parent(), "_on_Game_quit")
	connect("gameover", get_parent(), "_on_Game_gameover")

func _process(delta):
	# Make objects of the group "order" appear in proper draw order
	for object in get_tree().get_nodes_in_group("order"):
		object.z_index = object.position.y
	
	if not paused:
		# Handle input
		if Input.is_action_just_pressed("toggle_menu"):
			$IngameMenu.toggle_visibility()
		
		# Handle scoring
		# total is maximum possible score, assuming all tiles connected using autotile
		# (imagine the free space visible in single colour tiles as free)
		var total = float(76*39*2)#float(76*39)#float(80*45)
		var green = 0
		var blue = 0
		var orange = 0
		var pink = 0
		for x in range(0, 80):
			for y in range(0, 45):
				var index = $PaintMap.get_cell(x, y)
				var score = 1
				if $PaintMap.get_cell_autotile_coord(x, y) != Vector2(3, 2):
					# A tile of colour is worth double if it connects with other tiles of colour using autotile
					score = 2
				match index:
					0:
						green += score
					1:
						blue += score
					2:
						orange += score
					3:
						pink += score
		$GameOverlay.setColours(green / total, blue / total, orange / total, pink / total)
		
		# Process time
		time_remaining -= delta
		$GameOverlay.setTimer(time_remaining)
		if time_remaining <= 0:
			emit_signal("gameover", green / total) # Score of player green

func _physics_process(_delta):
	if not paused:
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
