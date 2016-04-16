
extends Node2D

var type
var shape_manager
var visual

func _ready():
	pass

func setup(type):
	shape_manager = get_node("/root/shape_manager")
	visual = get_node("visual")
	self.type = type
	visual.set_texture(shape_manager.shape_types[type])

func pickup():
	visual.hide()

func drop():
	visual.show()
