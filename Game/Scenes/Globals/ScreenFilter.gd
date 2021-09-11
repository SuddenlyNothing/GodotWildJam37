extends CanvasLayer

onready var color_rect := $ColorRect

func set_brightness(val) -> void:
	color_rect.get_material().set_shader_param("brightness", val)


func set_contrast(val) -> void:
	color_rect.get_material().set_shader_param("contrast", val)


func set_saturation(val) -> void:
	color_rect.get_material().set_shader_param("saturation", val)
