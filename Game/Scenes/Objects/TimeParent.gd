# This is purely to make level design easier
# This node will set the active_times for all of its child nodes
tool
class_name TimeParent
extends Node2D

export var active_in_time_0 := false
export var active_in_time_1 := false

func _ready() -> void:
	for child in get_children():
		if not child is TimeObject:
			continue
		
		var array: PoolIntArray = []
		
		if active_in_time_0:
			array.append(0)
		if active_in_time_1:
			array.append(1)
		
		child.active_times = array
