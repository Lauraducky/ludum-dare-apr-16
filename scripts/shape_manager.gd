extends Node

var shape_types = {}
var image_directory = "res://images/shapes/"

var star = preload("res://images/shapes/star.png")
var moon = preload("res://images/shapes/moon.png")

func _ready():
	shape_types["star"] = star
	shape_types["moon"] = moon

