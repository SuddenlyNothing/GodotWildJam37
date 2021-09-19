tool
extends Area2D

onready var t := $Tween
onready var label := $CanvasLayer/Control/M/Label

export(String, MULTILINE) var dialog := "" setget set_text

var cps := 25

func _ready() -> void:
	label.hide()
	set_active(true)


func set_text(text) -> void:
	dialog = text
	if get_node_or_null("CanvasLayer/Control/M/Label"):
		$CanvasLayer/Control/M/Label.text = text

func _on_Dialog_body_entered(body) -> void:
	if not body.is_in_group("player"):
		return
	set_active(true)


func _on_Dialog_body_exited(body) -> void:
	if not body.is_in_group("player"):
		return
	set_active(false)


func set_active(val : bool) -> void:
	label.visible = val
	if val:
		var total_chars : float = label.text.length()
		var duration : float = total_chars/cps
		print(duration)
		t.interpolate_property(label, "percent_visible", 0, 1, duration)
		t.start()
	else:
		t.remove_all()
		label.visible_characters = 0
