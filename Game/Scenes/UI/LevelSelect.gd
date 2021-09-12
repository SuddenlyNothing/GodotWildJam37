extends Control

onready var sprite := $Sprite
onready var sprite2 := $Sprite2
onready var buttons := $Buttons
onready var t := $Tween
onready var gear := $Gear
onready var gear2 := $Gear2
onready var close := $Close

var started := false

var level_path := "res://Scenes/Levels/Level_"

func _ready() -> void:
	var idx := 0
	for child in buttons.get_children():
		child.connect("pressed", self, "goto_scene", [idx])
		idx += 1


func _process(delta : float) -> void:
	sprite2.rotation = sprite.rotation * 60


func goto_scene(val : int) -> void:
	if started:
		return
	started = true
	gear.play()
	gear2.play()
	var duration : float = (30.0*(val+1))/360 * 3
	t.interpolate_property(sprite, "rotation_degrees", 0,
		30+(30*val), duration, Tween.TRANS_EXPO, Tween.EASE_OUT)
	t.interpolate_property(gear, "pitch_scale", 5, 0.5, duration, Tween.TRANS_EXPO, Tween.EASE_OUT)
	t.interpolate_property(gear2, "pitch_scale", 7, 1, duration, Tween.TRANS_EXPO, Tween.EASE_OUT)
	t.start()
	yield(t, "tween_all_completed")
	gear2.stop()
	gear.stop()
	close.play()
	yield(close, "finished")
#	Global.goto_scene(level_path + str(val) + ".tscn")
	Global.goto_scene(filename)
