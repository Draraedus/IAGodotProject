extends CharacterBody2D
class_name Character_pig

var _state_machine

@export_category("Variables")
@export var _move_speed: float = 128.0
@export var _friction: float = 0.8
@export var _acceleration: float = 0.4

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

var game_over : bool = false

func _ready():
	_state_machine = _animation_tree["parameters/playback"]
	
func _process(delta):
	if game_over == true:
		get_tree().change_scene_to_file("res://scenes/ui/game_over_message.tscn")

func _physics_process(delta: float):
	_move()
	_animate()
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if get_slide_collision(0).get_collider().name == "hog_enemy":
			game_over = true
	
func _move():
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction
		
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		return
	
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)
	
	velocity = _direction.normalized() * _move_speed

func _animate():
	if velocity.length() > 1:
		_state_machine.travel("walk")
		return
		
	_state_machine.travel("idle")
