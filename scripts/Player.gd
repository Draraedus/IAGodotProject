extends CharacterBody2D
class_name Character_pig

var _state_machine

@export_category("Variables")
@export var _move_speed: float = 128.0
@export var _friction: float = 0.8
@export var _acceleration: float = 0.4

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

func _ready():
	_state_machine = _animation_tree["parameters/playback"]

func _physics_process(delta: float):
	_move()
	_animate()
	move_and_slide()
	
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
