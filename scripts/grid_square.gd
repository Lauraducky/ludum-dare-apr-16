
extends Node2D

var loaded_shape = preload("res://scenes/shape.scn")
var contents

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func fill(shape):
	var new_shape = loaded_shape.instance()
	add_child(new_shape)
	new_shape.setup(shape)
	new_shape.set_pos(Vector2(32,32))

func empty():
	contents.queuefree()
	contents = null

func is_empty():
	return !contents == null
