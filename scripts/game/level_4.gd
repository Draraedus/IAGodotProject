extends Node2D

@onready var enemy = preload("res://scenes/characters/hog_enemy.tscn")

@onready var pause_menu: CanvasLayer = $Pause_menu
@onready var player : CharacterBody2D = $Player

var mob: CharacterBody2D
var mob1: CharacterBody2D
var mob2: CharacterBody2D
var mob3: CharacterBody2D
var mob4: CharacterBody2D
var mob5: CharacterBody2D
var mob6: CharacterBody2D

func _ready():
	pause_menu.node = self
	
	mob = enemy.instantiate()
	add_child(mob)
	mob1 = enemy.instantiate()
	add_child(mob1)
	mob2 = enemy.instantiate()
	add_child(mob2)
	mob3 = enemy.instantiate()
	add_child(mob3)
	mob4 = enemy.instantiate()
	add_child(mob4)
	mob5 = enemy.instantiate()
	add_child(mob5)
	mob6 = enemy.instantiate()
	add_child(mob6)
	
	mob.position = get_node("enemy_position1").position
	mob1.position =  get_node("enemy_position2").position
	mob2.position = get_node("enemy_position3").position
	mob3.position =  get_node("enemy_position4").position
	mob4.position =  get_node("enemy_position5").position
	mob5.position = get_node("enemy_position6").position
	mob6.position =  get_node("enemy_position7").position
	
	mob.target_path = player.position
	mob1.target_path = player.position
	mob2.target_path = player.position
	mob3.target_path = player.position
	mob4.target_path = player.position
	mob5.target_path = player.position
	mob6.target_path = player.position

func _process(delta: float):
	if Input.is_action_just_pressed("pause_game"):
		pause_menu.pause()
		
	mob.target_path = player.position
	mob1.target_path = player.position
	mob2.target_path = player.position
	mob3.target_path = player.position
	mob4.target_path = player.position
	mob5.target_path = player.position
	mob6.target_path = player.position
	
