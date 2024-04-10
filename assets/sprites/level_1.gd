extends Node2D

var path_finding = preload("res://scripts/logic/aStar.gd").new()

@onready var pause_menu: CanvasLayer = $Pause_menu
@onready var mob : CharacterBody2D = $hog_enemy
@onready var player : CharacterBody2D = $Player

var tempo_decorrido = 0.0
var path

func _ready():
	pause_menu.node = self
	
	path = path_finding.a_star(mob.position, player.position)
	mob.target_path = path
	path.pop_back()

func _process(delta: float):
	if Input.is_action_just_pressed("pause_game"):
		pause_menu.pause()
		
	tempo_decorrido += delta
	
	if tempo_decorrido >= 0.4:
		path = path_finding.a_star(mob.position, player.position)
		mob.target_path = path
		tempo_decorrido = 0.0
		
	if $hog_enemy && !path.size() <= 1:
		if mob.position.distance_to(path[0]) < mob._move_speed * delta:
			path.pop_front()
