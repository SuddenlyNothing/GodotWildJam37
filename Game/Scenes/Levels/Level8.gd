extends Node2D

export(String, FILE, "*.tscn") var next_scene

onready var player := $PlayerAnimated
onready var t := $Tween
onready var camera := $PlayerAnimated/Camera2D

var velocity := 0
var fall_speed := 1666.67

func _ready() -> void:
	MusicPlayer.play(0)
	t.interpolate_property(camera, "zoom", Vector2(0.7, 0.7), Vector2(10, 10),
		5, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 2)
	t.start()


func _physics_process(delta : float):
	player.position.y += velocity * delta
	if velocity > 600:
		return
	velocity += fall_speed * delta
	


func _on_Timer_timeout():
	Global.goto_scene(next_scene)
