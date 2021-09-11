extends TimeObject

export(NodePath) var target_path

onready var top := $Top

var normal_y := -14
var pressed_y := 5
var press_y := 10
var pressing := false
var pressed := false
var already_pressed := false

var move_speed := 200


func set_active(val : bool) -> void:
	set_physics_process(val)
	if val:
		pass
	else:
		pressing = false
		pressed = false
		already_pressed = false
		top.move_and_collide(Vector2(0, normal_y - top.position.y))


func _on_Area2D_body_entered(body):
	if not body.is_in_group("player"):
		return
	pressing = true


func _on_Area2D_body_exited(body):
	if not body.is_in_group("player"):
		return
	pressing = false


func _physics_process(delta : float) -> void:
	if pressing:
		if top.position.y < press_y:
			top.move_and_collide(Vector2.DOWN * move_speed * delta)
		elif not already_pressed:
			pressed = not pressed
			already_pressed = true
			if get_node(target_path).has_method("set_powered"):
				get_node(target_path).set_powered(pressed)
	else:
		already_pressed = false
		if pressed:
			if top.position.y > pressed_y:
				top.move_and_collide(Vector2.UP * move_speed * delta)
		else:
			if top.position.y > normal_y:
				top.move_and_collide(Vector2.UP * move_speed * delta)
