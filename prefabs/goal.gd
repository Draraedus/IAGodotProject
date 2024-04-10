extends Area2D

const player := preload("res://scripts/entities/player.gd")

var _player_ref: Character_pig = null

@onready var transition = get_parent().get_node("Transition")
@export var scene_levels : String = ""

func _on_body_entered(_body):
	if _body is Character_pig and !scene_levels == "":
		transition.change_scene(scene_levels)
	else:
		print("No scene Loaded")
