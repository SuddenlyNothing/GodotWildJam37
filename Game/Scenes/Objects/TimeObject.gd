extends Node2D
class_name TimeObject

export(PoolIntArray) var active_times

var is_active = false

# function that other nodes call to change the state
func change_state(val : int) -> void:
	if val in active_times:
		if is_active == false:
			set_active(true)
			show()
	elif is_active == true:
		set_active(false)
		hide()


# abstract function that inherited scenes will set to change active state
func set_active(val : bool) -> void:
	pass
