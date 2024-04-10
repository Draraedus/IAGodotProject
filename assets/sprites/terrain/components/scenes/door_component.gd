extends Area2D

class_name DoorComponent
const player := preload("res://scripts/player.gd")

var _player_ref: character_pig = null

@export_category("Variables")
@export var _teleport_position: Vector2

func _on_body_entered(_body) -> void:
	if _body is character_pig:
		_player_ref = _body
		_player_ref.global_position = _teleport_position
		
