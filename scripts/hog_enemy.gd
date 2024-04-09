extends CharacterBody2D

var _state_machine

@export_category("Variables")
@export var _move_speed: float = 100.0
@export var _friction: float = 0.8
@export var _acceleration: float = 0.4
@export var target_path : Array

@export_category("Objects")
@export var _animation_tree: AnimationTree = null


func _ready():
	_state_machine = _animation_tree["parameters/playback"]

func _physics_process(delta: float):
	_animate()
	_move()
	move_and_slide()
	
func _move():
	var _direction
	if target_path.size() > 1:
		_direction = (target_path[0] - Vector2(Vector2i(position))).normalized()
		print(_direction)
	else:
		_direction = Vector2.ZERO
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction
		
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		return
	
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)
	

func _animate():
	if velocity.length() > 2:
		_state_machine.travel("walk")
		return
		
	_state_machine.travel("idle")

