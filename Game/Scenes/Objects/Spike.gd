extends TimeObject

onready var collision := $Area2D/CollisionPolygon2D

# set collisions
func set_active(val : bool) -> void:
	collision.call_deferred("set_disabled", not val)
	.set_active(val)

# kill player
func _on_Area2D_body_entered(body) -> void:
	if not body.is_in_group("player"):
		return
	Global.restart_scene()
