extends StateMachine

func _ready() -> void:
	add_state("idle")
	add_state("jump")
	add_state("fall")
	add_state("walk")
	call_deferred("set_state", states.fall)


func _state_logic(delta : float) -> void:
	match state:
		states.idle:
			pass
		states.jump:
			parent.apply_velocity()
			parent.apply_jump_gravity(delta)
		states.fall:
			parent.apply_velocity()
			parent.apply_fall_gravity(delta)
			if Input.is_action_just_pressed("jump"):
				parent.jump_buffer.start()
		states.walk:
			parent.apply_velocity()
			parent.apply_fall_gravity(delta)


func _get_transition(delta : float):
	match state:
		states.idle:
			if Input.is_action_just_pressed("jump") or not parent.jump_buffer.is_stopped():
				return states.jump
			if parent.get_x_input() != 0:
				return states.walk
		states.jump:
			if parent.velocity.y >= 0 or parent.is_on_ceiling():
				return states.fall
			if parent.is_on_floor():
				return states.idle
		states.fall:
			if Input.is_action_just_pressed("jump") and not parent.coyote_timer.is_stopped():
				return states.jump
			if parent.is_on_floor():
				return states.idle
		states.walk:
			if Input.is_action_just_pressed("jump"):
				return states.jump
			if not parent.is_on_floor():
				return states.fall
	return null


func _enter_state(new_state, old_state) -> void:
	match new_state:
		states.idle:
			pass
		states.jump:
			parent.jump()
		states.fall:
			if old_state == states.walk:
				parent.coyote_timer.start()
		states.walk:
			pass


func _exit_state(old_state, new_state) -> void:
	match old_state:
		states.idle:
			pass
		states.jump:
			pass
		states.fall:
			pass
		states.walk:
			pass
