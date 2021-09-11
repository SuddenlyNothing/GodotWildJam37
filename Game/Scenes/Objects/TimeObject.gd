extends Node2D
class_name TimeObject

export(PoolIntArray) var active_times

var is_active = false


func _ready() -> void:
	yield(get_parent(), "ready")
	set_active(false)
	hide()

# function that other nodes call to change the state
func change_state(val : int) -> void:
	if val in active_times:
		if is_active == false:
			set_active(true)
	elif is_active == true:
		set_active(false)

# overridable function that inherited scenes will set to change active state
func set_active(val : bool) -> void:
	is_active = val
	visible = val


func set_preview(val : bool) -> void:
	visible = val
	if val:
		modulate = Color(1, 1, 1, 0.5)
	else:
		modulate = Color(1, 1, 1, 1)
