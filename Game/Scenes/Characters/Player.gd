class_name Player
extends KinematicBody2D

signal toggle_state

export(float) var jump_height : float = 150.0
export(float) var jump_time_to_peak : float = 0.4
export(float) var jump_time_to_descent : float = 0.6
export(float) var move_speed : float = 200.0

onready var coyote_timer := $CoyoteTimer
onready var player_animated := $Flip/PlayerAnimated
onready var jump_buffer := $JumpBuffer
onready var flip := $Flip
onready var jump := $Jump
onready var walk := $Walk

var ground_snap := Vector2.DOWN * 8
var snap := ground_snap
onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var velocity := Vector2.ZERO
var max_fall_speed := 600


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_time"):
		emit_signal("toggle_state")


func apply_fall_gravity(delta : float) -> void:
	if velocity.y > max_fall_speed:
		return
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
	
	set_facing(x_dir)
	return x_dir


func apply_velocity():
	velocity.x = get_x_input() * move_speed
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)

# only flips children of flip node
func set_facing(val) -> void:
	if flip.scale.x > 0 and val < 0:
		flip.scale.x *= -1
	if flip.scale.x < 0 and val > 0:
		flip.scale.x *= -1


func _on_PlayerAnimated_frame_changed():
	if player_animated.animation == "run":
		if player_animated.frame == 0 or player_animated.frame == 3:
			walk.play()
