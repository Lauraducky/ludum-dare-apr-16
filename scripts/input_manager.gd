
extends Node

var mouse_down = false
var holding = null

func _ready():
	set_process_input(true)

func _input(event):
	if(event.type == InputEvent.MOUSE_BUTTON):
		if(event.button_index == BUTTON_LEFT):
			if(event.pressed):
				#print("click!")
				mouse_down = true
			else:
				#print("up!")
				mouse_down = false
	elif(mouse_down && event.type == InputEvent.MOUSE_MOTION):
		#print("drag")