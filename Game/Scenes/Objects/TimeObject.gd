extends Node2D
class_name TimeObject

export(PoolIntArray) var active_times
export(Array, NodePath) var preview_node_paths

var shader_mat := preload("res://Assets/Shaders/Preview.tres")
var is_active = false
var is_previewing = false


func _ready() -> void:
	for node_path in preview_node_paths:
		var node = get_node(node_path)
		node.set("material", shader_mat.duplicate())
	yield(get_parent(), "ready")
	set_active(false)
	hide()

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
	else:
		set_previewing(false)

# overridable function that inherited scenes will set to change active state. Call .set_active(val) when overriding
func set_active(val : bool) -> void:
	set_shader(false)
	is_active = val
	set_deferred("visible", val)
#	call_deferred("_set_opacity", 1.0)

# TODO - some sort of indication for currently active objects that will become disabled in
#		 the previewed state
func set_previewing(val : bool) -> void:
	is_previewing = val
	
#	# Make sure object is fully visible if it's active in the current state and the previewed state
#	if is_previewing and is_active:
#		show()
#		_set_opacity(1.0)
#		return
#
#	# If not currently active, visibility is based on preview state
#	else:
#		visible = is_previewing
#		if is_previewing:
#			_set_opacity(0.5)
#		else:
#			_set_opacity(1.0)
	
	if is_active:
		if is_previewing:
			set_shader(false)
		else:
			set_shader(true, false)
	else:
		visible = is_previewing
		if is_previewing:
			set_shader(true, true)


#func _set_opacity(percent) -> void:
#	modulate.a = percent


func set_shader(is_active, is_green : bool = true):
	for node_path in preview_node_paths:
		var node = get_node(node_path)
		node.get_material().set_shader_param("is_active", is_active)
		node.get_material().set_shader_param("is_color_1", is_green)
