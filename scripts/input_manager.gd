
extends Node

var current_scene

func _ready():
	set_process_input(true)

func _input(event):
	if(event.type == InputEvent.MOUSE_BUTTON):
		if(event.button_index == BUTTON_LEFT):
			if(event.pressed):
				if(current_scene.has_method("mouse_down")):
					current_scene.mouse_down(event.pos)
			else:
				if(current_scene.has_method("mouse_up")):
					current_scene.mouse_up(event.pos)
	elif(event.type == InputEvent.MOUSE_MOTION):
		if(current_scene.has_method("mouse_move")):
			current_scene.mouse_move(event.pos)

func set_current_scene(area):
	self.current_scene = area
