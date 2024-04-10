extends CanvasLayer

var node: Node2D

var can_resume: bool = false

func _ready():
	hide()

func _process(_delta):
	if can_resume && Input.is_action_just_pressed("pause_game"):
		resume()
		
	elif !can_resume && Input.is_action_just_released("pause_game"):
		can_resume = true

func resume():
	hide()
	node.get_tree().paused = false

func pause():
	show()
	can_resume = false
	node.get_tree().paused = true
