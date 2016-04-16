
extends Node

var shape_types = {}
var image_directory = "res://images/shapes/"

#things to load
var star = preload("res://images/shapes/star.tex")
var moon = preload("res://images/shapes/moon.tex")
var heart = preload("res://images/shapes/heart.tex")
var club = preload("res://images/shapes/club.tex")

func _ready():
	shape_types["star"] = star
	shape_types["moon"] = moon
	shape_types["heart"] = heart
	shape_types["club"] = club
