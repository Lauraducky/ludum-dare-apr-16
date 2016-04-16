
extends Node

var holding = false
var play_area

func _ready():
	set_process_input(true)

func _input(event):
	if(event.type == InputEvent.MOUSE_BUTTON):
		if(event.button_index == BUTTON_LEFT):
			if(event.pressed):
				holding = play_area.pickup(event.pos)
			else:
				if(holding):
					play_area.drop(event.pos)
					holding = false
	elif(holding && event.type == InputEvent.MOUSE_MOTION):
		play_area.move(event.pos)

func set_play_area(area):
	self.play_area = area
