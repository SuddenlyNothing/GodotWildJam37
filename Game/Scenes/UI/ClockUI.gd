extends Control


var current_time: int = 12 setget set_current_time
export var hand_rotate_time := 1.0

onready var clock_hand: TextureRect = $ClockHand
onready var t: Tween = $Tween


# For DEBUG --> later will operate on signals
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("progress_time"):
		self.current_time += 1
	if event.is_action_pressed("regress_time"):
		self.current_time -= 1


func set_current_time(val : int) -> void:
	val = wrapi(val, 1, 13)
	current_time = val
	_set_clock_hand(current_time)


func _set_clock_hand(new_time: int) -> void:
	var degrees := 30
	# Use current rotation so there's no skipping if the player changes the time while
	# the hand is already moving
	var start := clock_hand.rect_rotation
	var target := new_time * degrees
	var rotation := _fix_rotation(target - start)
	t.interpolate_property(clock_hand, "rect_rotation", start, start + rotation, hand_rotate_time)
	t.start()


# Used to make sure the ClockHand always uses the shortest rotation
# For example, instead of moving +330 degrees to go from 1 to 12, it will only move -30 degrees
func _fix_rotation(rotation: float) -> float:
	if abs(rotation) > 180:
		rotation = wrapi(rotation - 360, -180, 180)
	return rotation


func _on_time_changed(old_time, new_time) -> void:
	current_time = new_time
