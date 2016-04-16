
extends Node2D

var width = 3
var height = 3
var src_file

var shapes = []
var shape_size = 64

var shape = preload("res://scenes/shape.scn")

func _ready():
	setup("null")
	pass

func setup(src_file):
	
	update()
	
#	var new_shape = shape.instance()
#	add_child(new_shape)
#	new_shape.setup("heart")
#	new_shape.set_pos(Vector2(64,64))

#make a super simple grid
func _draw():
	var total_width = width * shape_size
	for i in range(height+1):
		var y = i * shape_size
		draw_line(Vector2(0, y), Vector2(total_width, y), Color(255,255,255))
	
	var total_height = height * shape_size
	for j in range(width+1):
		var x = j * shape_size
		draw_line(Vector2(x,0), Vector2(x, total_height), Color(255,255,255))
	