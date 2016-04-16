
extends Node2D

var type
var shape_manager

func _ready():
	pass

func setup(type):
	shape_manager = get_node("/root/shape_manager")
	self.type = type
	get_node("visual").set_texture(shape_manager.shape_type[type])
	