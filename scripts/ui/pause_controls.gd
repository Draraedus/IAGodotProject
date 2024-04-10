extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	get_node("Back").pressed.connect(on_button_pressed.bind(get_node("Back")))

func on_button_pressed(_button: Button):
	hide()
	get_parent().get_node("pause_principal").show()
	
