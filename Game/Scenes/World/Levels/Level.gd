class_name Level
extends Node2D

export var starting_time := 0

onready var player_start_pos: Vector2 = $PlayerStart.position
onready var goal: Area2D = $Goal
onready var fall_kill_zone: Area2D = $FallKillZone
