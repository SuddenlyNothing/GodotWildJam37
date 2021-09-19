extends Node2D

var player: Player
var current_time := 0

export(Array, PackedScene) var levels
var level_index := 0

# The LevelParent is so you can easily test levels by adding/deleting them
# to the World scene. It shouldn't be necessarily for release
onready var current_level: Level = $LevelParent.get_child(0)
onready var player_start_pos: Vector2 = current_level.player_start_pos
onready var camera: Camera2D = $Camera2D

const player_scene := preload("res://Scenes/Characters/Player.tscn")


func _ready() -> void:
	setup_current_level()


func spawn_player() -> void:
	if player:
		player.queue_free()
	
	player = player_scene.instance()
	player.connect("toggle_state", self, "_on_toggle_state")
	add_child(player)
	player.position = player_start_pos
	camera.get_parent().remove_child(camera)
	player.add_child(camera)


func load_level(level_to_load: PackedScene) -> void:
	var new_level: Level = level_to_load.instance()
	if current_level:
		current_level.queue_free()
	
	current_level = new_level
	add_child(current_level)
	setup_current_level()
	

func setup_current_level() -> void:
	if not current_level:
		return
	
	player_start_pos = current_level.player_start_pos
	current_level.goal.connect("body_entered", self, "_on_Goal_body_entered")
	current_level.fall_kill_zone.connect("body_entered", self, "_on_FallKillZone_body_entered")
	
	change_time(current_level.starting_time)
	spawn_player()


func level_complete() -> void:
	player.queue_free()
	level_index += 1
	if level_index >= levels.size():
		you_win_the_game()
	else:
		var next_level_scene: PackedScene = levels[level_index]
		load_level(next_level_scene)


func player_die() -> void:
	current_time = current_level.starting_time
	change_time(current_time)
	player.position = player_start_pos


func change_time(time: int) -> void:
	get_tree().call_group("time_object", "change_state", time)


func you_win_the_game() -> void:
	print("wowwwwwwwww, i guess you win or wtvr")

func _on_toggle_state() -> void:
	if current_time == 0:
		current_time = 1
	elif current_time == 1:
		current_time = 0
	
	change_time(current_time)


func _on_Goal_body_entered(body) -> void:
	if body is Player:
		level_complete()


func _on_FallKillZone_body_entered(body) -> void:
	if body is Player:
		player_die()
