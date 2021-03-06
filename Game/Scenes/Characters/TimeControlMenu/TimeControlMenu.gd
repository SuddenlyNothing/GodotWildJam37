class_name TimeControlMenu
extends Node2D

var current_time := 0 setget set_current_time
var selected_time := current_time setget set_selected_time

# Use current_time and selected_time as indexes with the buttons array
onready var buttons := $Buttons.get_children()


func _ready() -> void:
	self.selected_time = current_time
	self.current_time = current_time
	hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("progress_time"):
		move_clockwise()
	if event.is_action_pressed("regress_time"):
		move_counterclockwise()
	if event.is_action_pressed("debug"):
		confirm_selection()
	if event.is_action_released("time_control_menu"):
		close_menu()


# Called by Player
func open_menu() -> void:
#	self.selected_time = current_time
	show()
	get_tree().paused = true

func close_menu() -> void:
	hide()
	get_tree().paused = false
#	show_time_object_previews(current_time)

# Move the selection cursor
func move_clockwise() -> void:
	self.selected_time += 1
	show_time_object_previews(selected_time)

func move_counterclockwise() -> void:
	self.selected_time -= 1
	show_time_object_previews(selected_time)

func confirm_selection() -> void:
	self.current_time = selected_time


func change_time_object_states(time : int) -> void:
	get_tree().call_group("time_object", "change_state", time)


func show_time_object_previews(time : int) -> void:
	get_tree().call_group("time_object", "preview_state", time)


func set_current_time(new_time : int) -> void:
	var old_time = current_time
#	if old_time == new_time:
#		return
	
	new_time = wrapi(new_time, 0, 12)
	current_time = new_time
	
	# Update button states, mostly just changes button modulate color
	var old_button: HourButton = buttons[old_time]
	var selected_button: HourButton = buttons[selected_time]
	old_button.is_confirmed = false
	selected_button.is_confirmed = true
	
	change_time_object_states(current_time)


func set_selected_time(new_selection : int) -> void:
	var old_time = selected_time
	selected_time = wrapi(new_selection, 0, 12)
	
	# Update button states, mostly just shows/hides the selection ring
	var selected_button: HourButton = buttons[selected_time]
	var old_button: HourButton = buttons[old_time]
	old_button.is_selected = false
	selected_button.is_selected = true
