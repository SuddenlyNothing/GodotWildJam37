extends Node2D
class_name TimeObject

export(PoolIntArray) var active_times

var is_active = false


func _ready() -> void:
	yield(get_tree().root, "ready")
	set_active(false)
	hide()

# function that other nodes call to change the state
func change_state(val : int) -> void:
	if val in active_times:
		if is_active == false:
			is_active = true
			set_active(true)
			show()
	elif is_active == true:
		is_active = false
		set_active(false)
		hide()

# abstract function that inherited scenes will set to change active state
func set_active(val : bool) -> void:
	pass


func set_preview(val : bool) -> void:
	visible = val
	if val:
		modulate = Color(1, 1, 1, 0.5)
	else:
		modulate = Color(1, 1, 1, 1)
