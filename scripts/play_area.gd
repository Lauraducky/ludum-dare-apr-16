
extends Node2D

var width = 3
var height = 3
var src_file

var shape_ref = []
const shape_size = 64
var name

var loaded_shape = preload("res://scenes/shape.scn")

func _ready():
	setup("res://levels/test.txt")
	pass

func setup(src_file):
	var file = File.new()
	file.open(src_file, File.READ)
	
	name = file.get_line()
	var line = file.get_line()
	var dimens = line.split(" ")
	height = int(dimens[0])
	width = int(dimens[1])
	
	var y = 0
	while(!file.eof_reached()):
		line = file.get_line()
		var shapes = line.split(" ")
		var x = 0
		for shape in shapes:
			if (shape != "#"):
				add_shape(shape, x, y)
			shape_ref.append(shape)
			x += 1
		y += 1
	file.close()
	update()
	

func add_shape(shape, x, y):
	var new_shape = loaded_shape.instance()
	add_child(new_shape)
	new_shape.setup(shape)
	new_shape.set_pos(Vector2(x * shape_size, y * shape_size))

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
	