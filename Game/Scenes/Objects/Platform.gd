extends TimeObject

onready var collision := $KinematicBody2D/CollisionShape2D

# set collisions
func set_active(val : bool) -> void:
	collision.call_deferred("set_disabled", not val)
	.set_active(val)
