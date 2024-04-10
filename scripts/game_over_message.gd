extends Control

var game_over_button

# Called when the node enters the scene tree for the first time.
func _ready():
	game_over_button = get_node("VBoxContainer/back")
	game_over_button.pressed.connect(_on_game_over_button_pressed.bind(game_over_button))
	game_over_button.mouse_exited.connect(mouse_interaction.bind(game_over_button, "exited"))
	game_over_button.mouse_entered.connect(mouse_interaction.bind(game_over_button, "entered"))
	

func _on_game_over_button_pressed(button: Button):
	var _change_scene: bool = get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")

func mouse_interaction(button: Button, state: String):
	match state:
		"exited":
			button.modulate.a = 1.0
			
		"entered":
			button.modulate.a = 0.5
