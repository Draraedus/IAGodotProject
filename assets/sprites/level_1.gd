extends Node2D

@onready var pause_menu: CanvasLayer = $Pause_menu

func _ready():
	pause_menu.node = self

func _process(delta: float):
	if Input.is_action_just_pressed("pause_game"):
		pause_menu.pause()
