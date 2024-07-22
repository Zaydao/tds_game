extends Marker2D


@export var player_path: NodePath = "/root/world/player"

func _ready():
	if has_node(player_path):
		var player = get_node(player_path) as Node2D
		if player:
			print("Player node found:", player)
		else:
			print("Player node is not assigned or found.")
	else:
		print("Node path does not exist:", player_path)
