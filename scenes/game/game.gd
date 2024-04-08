extends Node2D

var path
var mob
var player
var tile_map
var tile_path 
var tempo_decorrido = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_map = get_node("TileMap")
	player = get_node("Player")
	mob = get_node("hog_enemy")
	tile_path = a_star(tile_map.local_to_map(mob.position), tile_map.local_to_map(player.position), tile_map.get_used_cells(0))
	path = tile_path.map(func(tile): return tile_map.map_to_local(tile))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	 # Incrementa o tempo decorrido desde o último quadro
	tempo_decorrido += delta
	
	# Verifica se passaram 2 segundos
	if tempo_decorrido >= 0.5:
		# Execute sua função aqui
		tile_path = a_star(tile_map.local_to_map(mob.position), tile_map.local_to_map(player.position), tile_map.get_used_cells(0))
		path = tile_path.map(func(tile): return tile_map.map_to_local(tile))
		
		# Reinicie o tempo decorrido
		tempo_decorrido = 0.0
		
	if $hog_enemy && !path.is_empty():
		mob.target_path = path
		if mob.position.distance_to(path[0]) < mob._move_speed * delta:
			path.pop_front()

class NodeAux:
	var position: Vector2i
	var parent: NodeAux = null
	var g: float = 0
	var h: float = 0
	var f: float = 0

	func _init(pos: Vector2i, par: NodeAux = null):
		position = pos
		parent = par

func a_star(start_pos: Vector2i, end_pos: Vector2i, valid_coordinates: Array) -> Array:
	var open_list = []
	var closed_list = []

	var start_node = NodeAux.new(start_pos)
	var end_node = NodeAux.new(end_pos)

	open_list.append(start_node)

	while open_list.size() > 0:
		var current_node = open_list[0]
		var current_index = 0

		for i in range(open_list.size()):
			if open_list[i].f < current_node.f:
				current_node = open_list[i]
				current_index = i

		open_list.remove_at(current_index)
		closed_list.append(current_node)

		if current_node.position == end_node.position:
			var path = []
			while current_node != null:
				path.append(current_node.position)
				current_node = current_node.parent
			path.reverse()
			return path

		var neighbors = get_neighbors(current_node.position, valid_coordinates)

		for neighbor in neighbors:
			var in_closed = false
			for closed_node in closed_list:
				if closed_node.position == neighbor:
					in_closed = true
					break
			if in_closed:
				continue

			var g_cost = current_node.g + 1
			var h_cost = heuristic(neighbor, end_node.position)
			var f_cost = g_cost + h_cost

			var in_open = false
			for open_node in open_list:
				if open_node.position == neighbor and f_cost >= open_node.f:
					in_open = true
					break
			if in_open:
				continue

			var neighbor_node = NodeAux.new(neighbor, current_node)
			neighbor_node.g = g_cost
			neighbor_node.h = h_cost
			neighbor_node.f = f_cost

			open_list.append(neighbor_node)

	return []  # Se não for possível encontrar um caminho

func get_neighbors(position: Vector2i, valid_coordinates: Array) -> Array:
	var neighbors = [position + Vector2i(1, 0), position + Vector2i(-1, 0), position + Vector2i(0, 1), position + Vector2i(0, -1)]
	var valid_neighbors = []
	for neighbor in neighbors:
		if valid_coordinates.has(neighbor):
			valid_neighbors.append(neighbor)
	return valid_neighbors

func heuristic(current: Vector2i, goal: Vector2i) -> float:
	return abs(current.x - goal.x) + abs(current.y - goal.y)  # Distância de Manhattan

## Implementação do algoritmo AStar
#func a_star(start_node, end_node, tile_map):
	#var open_set = []
	#open_set.append(start_node)
	#
	#var came_from = {}
	#
	#var g_score = {}
	#g_score[start_node] = 0
	#
	#var f_score = {}
	#f_score[start_node] = heuristic(start_node, end_node)
	#
	#while open_set:
		#var current = get_lowest_f_score(open_set, f_score)
		#
		#if current == end_node:
			#return reconstruct_path(came_from, end_node)
		#
		#open_set.erase(current)
		#
		#for neighbor in get_neighbors(current):
			#var tentative_g_score = g_score[current] + distance(current, neighbor)
			#
			#if tentative_g_score < g_score.get(neighbor, float("inf")):
				#came_from[neighbor] = current
				#g_score[neighbor] = tentative_g_score
				#f_score[neighbor] = tentative_g_score + heuristic(neighbor, end_node)
		#
			#if not open_set.has(neighbor):
				#open_set.append(neighbor)
	#
	#return [] 
#
## Função heurística (distância euclidiana)
#func heuristic(a, b):
	#return a.distance_to(b)
#
## Função auxiliar para obter o nó com o menor valor f_score
#func get_lowest_f_score(open_set, f_score):
	#var lowest_score = float("inf")
	#var current_node = null
	#
	#for node in open_set:
		#if f_score[node] < lowest_score:
			#lowest_score = f_score[node]
			#current_node = node
	#
	#return current_node
#
## Função auxiliar para reconstruir o caminho
#func reconstruct_path(came_from, current):
	#var total_path = [current]
	#
	#while came_from.has(current):
		#current = came_from[current]
		#total_path.append(current)
	#
	#return total_path.reversed()
#
## Função auxiliar para obter os vizinhos de um nó
#func get_neighbors(node):
	## Implemente conforme a estrutura do seu mapa
	#pass
