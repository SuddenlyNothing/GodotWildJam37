extends Node2D

const PLAYER := preload("res://Scenes/Characters/Player.tscn")

export(bool) var can_toggle_time := true

onready var starting_position := $StartingPosition
onready var camera := $Camera2D
onready var toggle_timer := $ToggleTimer

var player
var current_time := 0

func _ready() -> void:
	change_time(current_time)
	spawn_player()
	if not can_toggle_time:
		toggle_timer.start()


func _process(delta : float) -> void:
	if player:
		if player.position.y > 1060:
			player.queue_free()
			spawn_player()
		camera.position = player.position
	if Input.is_action_just_pressed("toggle_time"):
		if current_time == 1:
			change_time(0)
		else:
			change_time(1)

func spawn_player() -> void:
	player = PLAYER.instance()
	player.position = starting_position.position
	call_deferred("add_child", player)


func change_time(time) -> void:
	print(time)
	get_tree().call_group("time_object", "change_state", time)
	current_time = time


func _on_ToggleTimer_timeout():
	if current_time == 1:
		change_time(0)
	else:
		change_time(1)
