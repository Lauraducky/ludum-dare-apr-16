
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

################
## SETUP CODE ##
################
func _ready():
	setup("res://levels/test.txt")
	get_node("/root/input_manager").set_current_scene(self)

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


################
## INPUT CODE ##
################
func mouse_move(pos):
	if (holding != null):
		held_item.set_pos(pos)

func mouse_down(pos):
	var coords = get_coords(pos)
	if(coords == null):
		return
	#They clicked on something! Is there something to pick up?
	var grid_square = grid[coords.x][coords.y].get_node("collider")
	if(!grid_square.is_empty()):
		var type = grid_square.pickup()
		held_item = loaded_shape.instance()
		add_child(held_item)
		held_item.setup(type)
		held_item.set_pos(pos)
		holding = grid_square

func mouse_up(pos):
	if (holding == null):
		return
	
	var coords = get_coords(pos)
	if(coords == null):
		holding.refill()
		held_item.queue_free()
		holding = null
		return
	
	var grid_square = grid[coords.x][coords.y].get_node("collider")
	if(grid_square.is_empty()):
		grid_square.fill(held_item.type)
		held_item.queue_free()
		holding.empty()
	else:
		holding.refill()
		held_item.queue_free()
	holding = null
	check_match()

func get_coords(pos):
	var x
	var y
	#Find the grid square where the user clicked, if they clicked in it
	x = int(pos.x / shape_size)
	y = int(pos.y / shape_size)
	
	if (x < 0 || x >= width || y < 0 || y >= height):
		return null
	return Vector2(x, y)


###################
## MATCHING CODE ##
###################
func check_match():
	for x in range(width):
		for y in range(height):
			var current = grid[x][y].get_node("collider")
			if (!current.is_empty()):
				var matches = get_adj_matches(x, y, current.get_type())
				if (matches.size() > 2):
					for i in matches:
						i.empty()
	check_empty()

func check_empty():
	for col in grid:
		for cell in col:
			if (!cell.get_node("collider").is_empty()):
				return false
	print("empty")
	return true

func get_adj_matches(x, y, type):
	var horizontal = get_hori_matches(x, y, type)
	var vertical = get_vert_matches(x, y, type)
	var output = []
	
	if(horizontal.size() > 1):
		for item in horizontal:
			output.append(item)
	
	if (vertical.size() > 1):
		for item in vertical:
			output.append(item)
	
	output.append(grid[x][y].get_node("collider"))
	return output

func get_hori_matches(x, y, type):
	var output = []
	var current = x
	
	while (current > 0):
		if (grid[current - 1][y].get_node("collider").get_type() == type):
			current -= 1
		else:
			break
	while (current < width):
		if (current == x):
			current += 1
			continue
		var square = grid[current][y].get_node("collider")
		if (square.get_type() == type):
			output.append(square)
		else:
			break
		current += 1
	return output

func get_vert_matches(x, y, type):
	var output = []
	var current = y
	
	while (current > 0):
		if (grid[x][current - 1].get_node("collider").get_type() == type):
			current -= 1
		else:
			break
	while (current < height):
		if (current == y):
			current += 1
			continue
		var square = grid[x][current].get_node("collider")
		if (square.get_type() == type):
			output.append(square)
		else:
			break
		current += 1
	return output
