extends Node

class NodeAux:
	var position: Vector2
	var parent: NodeAux = null
	var g: float = 0
	var h: float = 0
	var f: float = 0

	func _init(pos: Vector2, par: NodeAux = null):
		position = pos
		parent = par

# A* algorithm that consider the map as a infinity plane cartesian coordinate system
func a_star(start_pos: Vector2, end_pos: Vector2, ignored_position: Vector2, is_diagonal: bool = false) -> Array:
	var open_list: Array = []
	var closed_list: Array = []
	
	var limit_counter: int = 0
	
	var start_node: NodeAux = NodeAux.new(start_pos)
	var end_node: NodeAux = NodeAux.new(end_pos)

	open_list.append(start_node)

	while open_list.size() > 0:
		var current_node: NodeAux = open_list[0]
		var current_index: int = 0
		
		if limit_counter == 50:
			return [] # limit to pathfinding
		limit_counter += 1

		for i in range(open_list.size()):
			if open_list[i].f < current_node.f:
				current_node = open_list[i]
				current_index = i

		open_list.remove_at(current_index)
		closed_list.append(current_node)

		if current_node.position.distance_to(end_node.position) < 6.0:
			var path: Array = []
			while current_node != null:
				path.append(current_node.position)
				current_node = current_node.parent
			path.reverse()
			return path

		var neighbors: Array = get_neighbors(current_node.position, ignored_position, is_diagonal)

		for neighbor in neighbors:
			var in_closed: bool = false
			for closed_node in closed_list:
				if closed_node.position == neighbor:
					in_closed = true
					break
			if in_closed:
				continue

			var g_cost: int = current_node.g + 1
			var h_cost: int = heuristic(neighbor, end_node.position)
			var f_cost: int = g_cost + h_cost

			var in_open: bool = false
			for open_node in open_list:
				if open_node.position == neighbor and f_cost >= open_node.f:
					in_open = true
					break
			if in_open:
				continue

			var neighbor_node: NodeAux = NodeAux.new(neighbor, current_node)
			neighbor_node.g = g_cost
			neighbor_node.h = h_cost
			neighbor_node.f = f_cost

			open_list.append(neighbor_node)

	return []  # If path not encoutered

func get_neighbors(position: Vector2, ignored_positions: Vector2, is_diagonal: bool) -> Array:
	var neighbors: Array = []
	# horizontal and vertical neighbors
	neighbors.append(position + Vector2(5, 0))
	neighbors.append(position + Vector2(-5, 0))
	neighbors.append(position + Vector2(0, 5))
	neighbors.append(position + Vector2(0, -5))
	# diagonal neighbors if required
	if(is_diagonal):
		neighbors.append(position + Vector2(5, 5))
		neighbors.append(position + Vector2(-5, 5))
		neighbors.append(position + Vector2(5, -5))
		neighbors.append(position + Vector2(-5, -5))
	
	var valid_neighbors: Array = []
	for neighbor in neighbors:
		if ignored_positions.distance_to(Vector2(neighbor)) > 8:
			valid_neighbors.append(neighbor)
	return valid_neighbors

func heuristic(current: Vector2, goal: Vector2) -> float:
	return abs(current.x - goal.x) + abs(current.y - goal.y)  # Manhattan Distance
