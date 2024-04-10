extends Node2D

@onready var enemy = preload("res://scenes/characters/hog_enemy.tscn")

@onready var pause_menu: CanvasLayer = $Pause_menu
@onready var player : CharacterBody2D = $Player

var mob: CharacterBody2D
var mob1: CharacterBody2D

func _ready():
	pause_menu.node = self
	
	mob = enemy.instantiate()
	add_child(mob)
	mob1 = enemy.instantiate()
	add_child(mob1)
	
	mob.position = get_node("enemy_position1").position
	mob1.position =  get_node("enemy_position2").position
	
	mob.target_path = player.position
	mob1.target_path = player.position

func _process(delta: float):
	if Input.is_action_just_pressed("pause_game"):
		pause_menu.pause()
		
	mob.target_path = player.position
	mob1.target_path = player.position
	
