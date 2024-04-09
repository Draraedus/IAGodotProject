extends Node2D

var path_finding = preload("res://scripts/aStar.gd").new()

var path
var mob
var player
var tile_map
var tempo_decorrido = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_map = get_node("TileMap")
	player = get_node("Player")
	mob = get_node("hog_enemy")
	path = path_finding.a_star(mob.position, player.position)
	mob.target_path = path
	path.pop_back()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	 # Incrementa o tempo decorrido desde o último quadro
	tempo_decorrido += delta
	
	# Verifica se passaram 2 segundos
	if tempo_decorrido >= 0.6:
		path.append_array(path_finding.a_star(path[path.size()-1], player.position))
		tempo_decorrido = 0.0
		
	if $hog_enemy && !path.size() <= 1:
		if mob.position.distance_to(path[0]) < mob._move_speed * delta:
			path.pop_front()
	#print(path)

