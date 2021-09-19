extends Node2D

var player: Player
var current_time := 0

onready var player_start: Vector2 = $Level1/PlayerStart.position
onready var current_level := $Level1
onready var camera: Camera2D = $Camera2D

const player_scene := preload("res://Scenes/Characters/Player.tscn")


func _ready() -> void:
	get_tree().call_group("time_object", "change_state", 0)
	spawn_player()
	remove_child(camera)
	player.add_child(camera)


func spawn_player() -> void:
	player = player_scene.instance()
	add_child(player)
	player.position = player_start


func load_level() -> void:
	var new_level
	# insert load_level code
	
	current_level = new_level
	player_start = new_level.get_node("PlayerStart")
