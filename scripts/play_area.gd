
extends Node2D

const shape_size = 64
var name
var width = 3
var height = 3
var src_file

var grid = []

var holding
var held_item

#Items to instantiate
var loaded_shape = preload("res://scenes/shape.scn")
var grid_square = preload("res://scenes/grid_square.scn")

func _ready():
	setup("res://levels/test.txt")
	get_node("/root/input_manager").set_play_area(self)

func setup(src_file):
	var file = File.new()
	file.open(src_file, File.READ)
	
	name = file.get_line()
	var line = file.get_line()
	var dimens = line.split(" ")
	height = int(dimens[0])
	width = int(dimens[1])
	setup_grid()
	
	var y = 0
	while(!file.eof_reached()):
		line = file.get_line()
		var shapes = line.split(" ")
		var x = 0
		for shape in shapes:
			if (shape != "#"):
				grid[x][y].get_node("collider").fill(shape)
			x += 1
		y += 1
	file.close()
	update()

func setup_grid():
	for i in range(width):
		var col = []
		var x = i * shape_size
		for j in range(height):
			var y = j * shape_size
			var g = grid_square.instance()
			add_child(g)
			g.set_pos(Vector2(x, y))
			col.append(g)
		grid.append(col)

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

func is_solved():
	return false

func pickup(pos):
	var coords = get_coords(pos)
	if(coords == null):
		return false
	
	#They clicked on something! Is there something to pick up?
	var grid_square = grid[coords.x][coords.y].get_node("collider")
	if(!grid_square.is_empty()):
		var type = grid_square.pickup()
		held_item = loaded_shape.instance()
		add_child(held_item)
		held_item.setup(type)
		held_item.set_pos(pos)
		holding = grid_square
		return true
	return false

func get_coords(pos):
	var x
	var y
	#Find the grid square where the user clicked, if they clicked in it
	x = int(pos.x / shape_size)
	y = int(pos.y / shape_size)
	
	if (x < 0 || x >= width || y < 0 || y >= height):
		return null
	
	return Vector2(x, y)

func drop(pos):
	var coords = get_coords(pos)
	if(coords == null):
		holding.drop()
		held_item.queue_free()
		holding = null
		return
	
	var grid_square = grid[coords.x][coords.y].get_node("collider")
	if(grid_square.is_empty()):
		grid_square.fill(held_item.type)
		held_item.queue_free()
		holding.empty()
	else:
		holding.drop()

func move(pos):
	held_item.set_pos(pos)
