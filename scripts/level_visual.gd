
extends Node2D

var name
var path

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func setup(name, path):
	self.name = name
	self.path = path
