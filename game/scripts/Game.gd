extends Node2D

func _ready():
	pass

func _process(_delta):
	# Make objects of the group "order" appear in proper draw order
	for object in get_tree().get_nodes_in_group("order"):
		object.z_index = object.position.y

func _physics_process(_delta):
	# Handle blobs painting the world (the tilemap "PaintMap")
	for blob in get_tree().get_nodes_in_group("blob"):
		var coordinates = (blob.global_position / 16.0).floor()
		$PaintMap.set_cellv(coordinates, 0)
		$PaintMap.update_bitmask_area(coordinates)
