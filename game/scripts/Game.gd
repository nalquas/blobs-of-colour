extends Node2D

func _ready():
	pass

func _process(_delta):
	# Make objects of the group "order" appear in proper draw order
	for object in get_tree().get_nodes_in_group("order"):
		object.z_index = object.position.y
