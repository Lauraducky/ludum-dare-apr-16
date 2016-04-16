
extends Node2D

var type
var shape_manager

func _ready():
	shape_manager = get_node("/root/shape_manager")

func setup(type):
	var visual = get_node("visual")
	self.type = type
	visual.set_texture(shape_manager.shape_types[type])
	visual.set_pos(Vector2(32,32))