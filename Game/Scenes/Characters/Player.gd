extends KinematicBody2D

export(float) var jump_height : float = 150.0
export(float) var jump_time_to_peak : float = 0.4
export(float) var jump_time_to_descent : float = 0.6
export(float) var move_speed : float = 200.0

onready var coyote_timer := $CoyoteTimer
onready var jump_buffer := $JumpBuffer
onready var flip := $Flip
onready var time_control_menu: TimeControlMenu = $TimeControlMenu

var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var velocity := Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	# Pauses the scene_tree until button is released
	if event.is_action_pressed("time_control_menu"):
		time_control_menu.open_menu()


func apply_fall_gravity(delta : float) -> void:
	velocity.y += fall_gravity * delta


func apply_jump_gravity(delta : float) -> void:
	velocity.y += jump_gravity * delta


func jump():
	velocity.y = jump_velocity

# used for applying x_velocity and changing to walk state
func get_x_input() -> float:
	var x_dir := 0.0
	
	if Input.is_action_pressed("left"):
		x_dir -= 1.0
	if Input.is_action_pressed("right"):
		x_dir += 1.0
	
	return x_dir


func apply_velocity():
	velocity.x = get_x_input() * move_speed
	velocity = move_and_slide(velocity, Vector2.UP)

# only flips children of flip node
func set_facing() -> void:
	var x_dir = get_x_input()
	if flip.scale.x > 0 and x_dir < 0:
		flip.scale.x *= -1
	if flip.scale.x < 0 and x_dir > 0:
		flip.scale.x *= -1
