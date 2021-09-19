extends Node2D

var player: Player
var current_time := 0

onready var current_level: Level = $LevelParent.get_child(0)
onready var player_start_pos: Vector2 = current_level.player_start_pos
onready var camera: Camera2D = $Camera2D

const player_scene := preload("res://Scenes/Characters/Player.tscn")


func _ready() -> void:
	load_level()
	spawn_player()
	remove_child(camera)
	player.add_child(camera)


func spawn_player() -> void:
	if player:
		player.queue_free()
	
	player = player_scene.instance()
	player.connect("toggle_state", self, "_on_toggle_state")
	add_child(player)
	player.position = player_start_pos


func load_level() -> void:
#	var new_level = insert load_level code
#	current_level = new_level

	player_start_pos = current_level.player_start_pos
	current_level.goal.connect("body_entered", self, "_on_Goal_body_entered")
	current_level.fall_kill_zone.connect("body_entered", self, "_on_FallKillZone_body_entered")
	
	change_time(current_level.starting_time)


func go_to_next_level() -> void:
	# load_level()
	print("next_level")


func player_die() -> void:
	player.position = player_start_pos
	current_time = current_level.starting_time
	change_time(current_time)


func change_time(time: int) -> void:
	get_tree().call_group("time_object", "change_state", time)


func _on_toggle_state() -> void:
	if current_time == 0:
		current_time = 1
	elif current_time == 1:
		current_time = 0
	
	change_time(current_time)


func _on_Goal_body_entered(body) -> void:
	if body is Player:
		go_to_next_level()


func _on_FallKillZone_body_entered(body) -> void:
	if body is Player:
		player_die()
