extends KinematicBody2D

export (String) var colour = "green"

func _ready():
	$AnimatedSprite.animation = colour
	$AnimatedSprite.play()
