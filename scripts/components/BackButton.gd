extends Button

@export var scene_path: String

func _on_back_button_pressed():
	var _change_scene: bool = get_tree().change_scene_to_file(scene_path)

func _on_mouse_exited():
	modulate.a = 1.0

func _on_mouse_entered():
	modulate.a = 0.5
