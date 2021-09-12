class_name HourButton
extends Sprite

var is_confirmed := false setget set_is_confirmed
var is_selected := false setget set_is_selected

var base_color := Color.white
var confirmed_color := Color.dodgerblue


func set_is_confirmed(val: bool) -> void:
	is_confirmed = val
	self_modulate = confirmed_color if is_confirmed else base_color


func set_is_selected(val: bool) -> void:
	is_selected = val
	$SelectionRing.visible = is_selected
