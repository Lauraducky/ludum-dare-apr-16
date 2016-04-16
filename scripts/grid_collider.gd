
extends CollisionShape2D

var loaded_shape = preload("res://scenes/shape.scn")
var contents

func _ready():
	pass

func fill(shape):
	var new_shape = loaded_shape.instance()
	add_child(new_shape)
	new_shape.setup(shape)
	contents = new_shape

func empty():
	contents.queue_free()
	contents = null
	
func is_empty():
	return contents == null

func pickup():
	if(contents != null):
		contents.hide()
		return contents.type
	return null

func drop():
	if(contents != null):
		contents.empty()
