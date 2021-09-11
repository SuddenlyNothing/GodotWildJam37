extends TimeObject

export(NodePath) var target_path

onready var top := $Top
onready var top_collision := $Top/CollisionShape2D
onready var area_collision := $Top/Area2D/CollisionShape2D
onready var base_collision := $Base/CollisionShape2D
onready var base_collision2 := $Base/CollisionShape2D2

var normal_y := -14
var pressed_y := 5
var press_y := 10
var pressing := false
var pressed := false
var already_pressed := false

var move_speed := 200

# set collisions, move button back in place, reset pressed vars
func set_active(val : bool) -> void:
	set_physics_process(val)
	top_collision.call_deferred("set_disabled", not val)
	area_collision.call_deferred("set_disabled", not val)
	base_collision.call_deferred("set_disabled", not val)
	base_collision2.call_deferred("set_disabled", not val)
	if val:
		pass
	else:
		pressing = false
		pressed = false
		already_pressed = false
		top.move_and_collide(Vector2(0, normal_y - top.position.y))
		if get_node(target_path).has_method("set_powered"):
				get_node(target_path).set_powered(false)
	.set_active(val)


func _on_Area2D_body_entered(body):
	if not body.is_in_group("player"):
		return
	pressing = true


func _on_Area2D_body_exited(body):
	if not body.is_in_group("player"):
		return
	pressing = false

# move down if player is there, if at the bottom set pressed
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

