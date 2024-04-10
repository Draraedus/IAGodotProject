extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_tree().get_nodes_in_group("select_level_button"):
		button.pressed.connect(on_button_pressed.bind(button))
		button.mouse_exited.connect(mouse_interaction.bind(button, "exited"))
		button.mouse_entered.connect(mouse_interaction.bind(button, "entered"))

func on_button_pressed(button: Button):
	match button.name:
		"level_1":
			var _level_1: bool = get_tree().change_scene_to_file("res://assets/sprites/terrain/levels/scenes/level_1.tscn")
			
		"level_2":
			var _level_2: bool = get_tree().change_scene_to_file("res://assets/sprites/terrain/levels/scenes/level_2.tscn")
			
		"level_3":
			var _level_3: bool = get_tree().change_scene_to_file("res://assets/sprites/terrain/levels/scenes/level_3.tscn")
			
		"level_4":
			var _level_4: bool = get_tree().change_scene_to_file("res://assets/sprites/terrain/levels/scenes/level_4.tscn")


func mouse_interaction(button: Button, state: String):
	match state:
		"exited":
			button.modulate.a = 1.0
			
		"entered":
			button.modulate.a = 0.5
