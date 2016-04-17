
extends Node2D

var lvl_size = 128
var separation = 20
var x_offset = 64
var y_offset = 64

var level_scene = preload("res://scenes/level_visual.scn")

func _ready():
	load_levels("res://levels/levels.txt")
	pass

func load_levels(src_file):
	var num_levels = 0
	var file = File.new()
	file.open(src_file, File.READ)
	
	while(!file.eof_reached()):
		print(file.eof_reached())
		var name = file.get_line()
		print(name)
		if (file.eof_reached()):
			break
		var path = file.get_line()
		
		var new_lvl = level_scene.instance()
		add_child(new_lvl)
		new_lvl.set_pos(Vector2((lvl_size + separation)* num_levels + x_offset, y_offset))
		new_lvl.setup(name, path)
		num_levels += 1
	file.close()
