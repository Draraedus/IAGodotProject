extends CharacterBody2D

var _state_machine
var path_finding = preload("res://scripts/logic/aStar.gd").new()
var path: Array
var tempo_decorrido = 0.0

@export_category("Variables")
@export var _move_speed: float = 100.0
@export var _friction: float = 0.8
@export var _acceleration: float = 0.4
@export var target_path : Vector2

@export_category("Objects")
@export var _animation_tree: AnimationTree = null


func _ready():
	_state_machine = _animation_tree.get("parameters/playback")
	
	path = path_finding.a_star(position, target_path)
	
func _physics_process(_delta: float):
	
	tempo_decorrido += _delta
	if tempo_decorrido >= 0.4:
		path = path_finding.a_star(position, target_path)
		tempo_decorrido = 0.0
	
	if !path.size() <= 1:
		if position.distance_to(path[0]) < _move_speed * _delta:
			path.pop_front()
	_animate()
	_move()
	move_and_slide()
	
func _move():
	var _direction
	if path.size() > 1:
		_direction = (Vector2(Vector2i(path[0])) - Vector2(Vector2i(position)))
	else:
		_direction = Vector2.ZERO
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction.normalized()
		_animation_tree["parameters/walk/blend_position"] = _direction.normalized()
		
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		return
	
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)
	

func _animate():
	if velocity.length() > 2.:
		_state_machine.travel("walk")
		return
		
	_state_machine.travel("idle")
