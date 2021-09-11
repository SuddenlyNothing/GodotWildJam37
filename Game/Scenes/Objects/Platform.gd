extends TimeObject

onready var collision := $KinematicBody2D/CollisionShape2D

func set_active(val : bool) -> void:
	collision.call_deferred("set_disabled", val)
