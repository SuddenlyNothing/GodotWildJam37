extends Node2D



func _on_Button3_pressed():
	get_tree().call_group("time_object", "change_state", 1)


func _on_Button4_pressed():
	get_tree().call_group("time_object", "change_state", 2)


func _on_Button5_pressed():
	get_tree().call_group("time_object", "change_state", 3)
