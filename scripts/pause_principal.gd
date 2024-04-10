extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_tree().get_nodes_in_group("pause_buttons"):
		button.pressed.connect(on_button_pressed.bind(button))
		button.mouse_exited.connect(mouse_interaction.bind(button, "exited"))
		button.mouse_entered.connect(mouse_interaction.bind(button, "entered"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_button_pressed(button: Button):
	match button.name:
		"resume":
			get_parent().resume()
			
		"controls":
			hide()
			get_parent().get_node("pause_controls").show()
			
		"menu":
			var _game: bool = get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")
			
		"desktop":
			get_tree().quit()
			
func mouse_interaction(button: Button, state: String):
	match state:
		"exited":
			button.modulate.a = 1.0
			
		"entered":
			button.modulate.a = 0.5
