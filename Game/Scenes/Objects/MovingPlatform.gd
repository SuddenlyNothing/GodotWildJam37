extends TimeObject

export(float) var duration := 2.0

var target_pos: Vector2
var trans := Tween.TRANS_SINE
var easing := Tween.EASE_IN_OUT

var target_index := 1
onready var origin := position
onready var targets := [origin]

onready var collision := $KinematicBody2D/CollisionShape2D
onready var t := $Tween


func _ready() -> void:
	init_targets_array()
	target_pos = targets[target_index]


func _physic_process(delta: float) -> void:
	if not position == target_pos and not t.is_active():
		tween_to_target()
		print("tweening from %s to %s" % [position, target_pos])


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
	
	# If tween has been activated already, we'll toggle stop/resume
	if t.is_active():
		if is_active:
			t.resume_all()
		else:
			t.stop_all()
	# If tween hasn't been activated yet, or if we paused it at the very end of 
	# its last tween, we'll start it for the first time
	else:
		if is_active:
			tween_to_target()


func _on_Tween_tween_completed(_object, _key) -> void:
	target_index = wrapi(target_index + 1, 0, targets.size())
	target_pos = get_target()
	tween_to_target()


func get_target() -> Vector2:
	return targets[target_index]
