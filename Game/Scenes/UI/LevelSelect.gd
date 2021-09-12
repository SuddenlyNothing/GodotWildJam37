extends Control

onready var sprite := $Sprite
onready var sprite2 := $Sprite2
onready var buttons := $Buttons
onready var t := $Tween

var level_path := "res://Scenes/Levels/Level_"

func _ready() -> void:
	var idx := 0
	for child in buttons.get_children():
		child.connect("pressed", self, "goto_scene", [idx])
		idx += 1


func _process(delta : float) -> void:
	sprite2.rotation = sprite.rotation * 60


func goto_scene(val : int) -> void:
	if t.is_active():
		return
	t.interpolate_property(sprite, "rotation_degrees", 0,
		30+(30*val), 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
	t.start()
	yield(t, "tween_all_completed")
	Global.goto_scene(level_path + str(val) + ".tscn")
