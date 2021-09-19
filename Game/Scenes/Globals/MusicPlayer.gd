extends Node

onready var stage := $Stage
onready var menu := $Menu

var current = null

func play(val) -> void:
	if current == val:
		return
	current = val
	for child in get_children():
		child.stop()
	if val == 0:
		menu.play()
	elif val == 1:
		stage.play()
