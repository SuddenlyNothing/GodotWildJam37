extends TimeObject

onready var t := $Tween
onready var top := $Top
onready var bottom := $Bottom
onready var top_collision := $Top/CollisionShape2D
onready var bottom_collision := $Bottom/CollisionShape2D
onready var move := $Move
onready var stop := $Stop

var duration = 1
var top_bound = 100
var bottom_bound = 40
var trans := Tween.TRANS_SINE
var easing := Tween.EASE_OUT

# set collisions, reset gate positions
func set_active(val : bool) -> void:
	top_collision.call_deferred("set_disabled", not val)
	bottom_collision.call_deferred("set_disabled", not val)
	if val:
		top.position.y = -bottom_bound
		bottom.position.y = bottom_bound
	else:
		top.position.y = -bottom_bound
		bottom.position.y = bottom_bound
		set_powered(false)
	.set_active(val)

# open/close gate
func set_powered(val) -> void:
	if not is_active:
		return
	if val:
		t.remove_all()
		t.interpolate_property(top, "position:y", top.position.y, -top_bound, duration, trans, easing)
		t.interpolate_property(bottom, "position:y", bottom.position.y, top_bound, duration, trans, easing)
		t.start()
	else:
		t.remove_all()
		t.interpolate_property(top, "position:y", top.position.y, -bottom_bound, duration, trans, easing)
		t.interpolate_property(bottom, "position:y", bottom.position.y, bottom_bound, duration, trans, easing)
		t.start()


func _on_Tween_tween_completed(_object, _key):
	stop.play()
	move.stop()


func _on_Tween_tween_started(_object, _key):
	move.play()
