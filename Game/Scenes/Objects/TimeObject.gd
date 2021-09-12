extends Node2D
class_name TimeObject

export(PoolIntArray) var active_times

var is_active = false
var is_previewing = false


func _ready() -> void:
	yield(get_parent(), "ready")
	set_active(false)
	hide()
	print(name + " ready, is_active: " + str(is_active))

# function that other nodes call to change the state
func change_state(val : int) -> void:
	set_previewing(false) # as soon as the state changes, we turn off all previews
	if val in active_times:
		#if is_active == false:
		set_active(true)
	elif is_active == true:
		set_active(false)

###### BUG ######
#		if the object is already active, you have to switch back and forth to get it to toggle preview state
#		repro: set state to 2 o'clock, open the menu, move the cursor to 3 o'clock (nothing happens), move back
#			   to 2 o'clock, then to 3 o'clock again, previews work
func preview_state(val : int) -> void:
	if val in active_times:
		if is_previewing == false:
			set_previewing(true)
	elif is_previewing == true:
		set_previewing(false)

# overridable function that inherited scenes will set to change active state. Call .set_active(val) when overriding
func set_active(val : bool) -> void:
	is_active = val
	set_deferred("visible", val)
	call_deferred("_set_opacity", 1.0)

# TODO - some sort of indication for currently active objects that will become disabled in
#		 the previewed state
func set_previewing(val : bool) -> void:
	print(name + " set previewing")
	is_previewing = val
	
	# Make sure object is fully visible if it's active in the current state and the previewed state
	if is_previewing and is_active:
		show()
		_set_opacity(1.0)
		return
	
	# If not currently active, visibility is based on preview state
	else:
		visible = is_previewing
		if is_previewing:
			_set_opacity(0.5)
		else:
			_set_opacity(1.0)


func _set_opacity(percent) -> void:
	modulate.a = percent
