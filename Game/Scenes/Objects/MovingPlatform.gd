extends TimeObject

export(float) var duration := 2.0
export(bool) var is_powered := true

var target_pos: Vector2
var trans := Tween.TRANS_SINE
var easing := Tween.EASE_IN_OUT

var target_index := 1
onready var origin := position
onready var targets := [origin]

onready var collision := $KinematicBody2D/CollisionShape2D
onready var t := $Tween

#var last_pos := position
#var cur_pos := position
#var velocity := Vector2.ZERO

func _ready() -> void:
	init_targets_array()
	target_pos = targets[target_index]


# If we want to add the platform's velocity to the player's...
#func _physics_process(delta: float) -> void:
#	last_pos = cur_pos
#	cur_pos = position
#	var distance_traveled := cur_pos - last_pos
#	velocity = distance_traveled / delta


func tween_to_target() -> void:
	t.remove_all()
	t.interpolate_property(self, "position", position, target_pos, duration, trans, easing)
	t.start()


func init_targets_array() -> void:
	for target in $Targets.get_children():
		targets.append(target.global_position)


# set collisions
func set_active(val : bool) -> void:
	collision.call_deferred("set_disabled", not val)
	.set_active(val)
	handle_tween()


func set_powered(val : bool) -> void:
	if not is_active:
		return
	is_powered = val
	handle_tween()


# Platform defaults to powered, so if there's no connected button, it'll just run
func handle_tween() -> void:
	# If tween has been activated already, we'll toggle stop/resume
	if t.is_active():
		if is_active and is_powered:
			t.resume_all()
		else:
			t.stop_all()
	# If tween hasn't been activated yet, or if we paused it at the very end of 
	# its last tween, we'll start it for the first time
	else:
		if is_active and is_powered:
			tween_to_target()


func _on_Tween_tween_completed(_object, _key) -> void:
	target_index = wrapi(target_index + 1, 0, targets.size())
	target_pos = get_target()
	tween_to_target()


func get_target() -> Vector2:
	return targets[target_index]
