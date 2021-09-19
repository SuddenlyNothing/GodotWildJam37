extends Area2D

export(String, FILE, "*.tscn") var next_scene

func _on_Goal_body_entered(body):
	if not body.is_in_group("player"):
		return
	Global.goto_scene(next_scene)
