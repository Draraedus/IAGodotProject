extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_tree().get_nodes_in_group("Button"):
		button.pressed.connect(on_button_pressed.bind(button))
		button.mouse_exited.connect(mouse_interaction.bind(button, "exited"))
		button.mouse_entered.connect(mouse_interaction.bind(button, "entered"))

func on_button_pressed(button: Button):
	match button.name:
		"Play":
			var _game: bool = get_tree().change_scene_to_file("res://scenes/game.tscn")
			
		"Controls":
			var _controls: bool = get_tree().change_scene_to_file("res://scenes/controls.tscn")
			
		"About":
			var _about: bool = get_tree().change_scene_to_file("res://scenes/about.tscn")
			
		"Github":
			var _open_github: bool = OS.shell_open("https://github.com/Draraedus/IAGodotProject")
			
		"Quit":
			get_tree().quit()

func mouse_interaction(button: Button, state: String):
	match state:
		"exited":
			button.modulate.a = 1.0
			
		"entered":
			button.modulate.a = 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
