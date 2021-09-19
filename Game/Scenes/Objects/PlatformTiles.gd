extends TimeObject

onready var platforms := $Platforms

func set_active(val : bool) -> void:
	#prints(val, "hello")
	platforms.set_collision_layer_bit(0, val)
	.set_active(val)
