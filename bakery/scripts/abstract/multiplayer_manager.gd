extends Node

var PLAYER_SCENE = preload("res://scenes/characters/player.tscn")
var is_game_start = true

# Spawn a player on all peers on game start, but after game start called locally only (no RPC)
@rpc("any_peer", "call_local", "reliable")
func spawn_player(player_id: int, player_info: Dictionary, spawn_position: Vector2):
	
	var player_instance = PLAYER_SCENE.instantiate()
	
	print("{MULTIPLAYER_MANAGER} Spawning player ", player_id, " at ", spawn_position, " on peer ", multiplayer.get_unique_id())
	
	player_instance.player_info = player_info
	player_instance.position = spawn_position
	player_instance.set_multiplayer_authority(player_id)
	player_instance.name = str(player_id)  # Unique name to avoid conflicts
	
	get_tree().current_scene.call_deferred("add_child", player_instance)
	
	#print("Network -> Player ", player_id, " spawned with authority: ", player_instance.get_multiplayer_authority(), "(Player name: )", player_info["name"])


## Adds all players in the list to the current scene node
# NOTE: this function must be called after the target location scene has been loaded (e.g. in scene's _ready() function)
## Use this method from host client (server) only.
## Use before the game starts only.
func spawn_players_on_game_start(players):
	if (not multiplayer.is_server()):
		return
	
	# Starting position
	var spawn_base = Vector2(100, 100)  # TODO: instead of static coordinates, pass the parent_node to a new global class that returns the cordinates of its player spawn
	# Space between players
	var offset = 50
	
	for i in players.size():
		var player_id = players.keys()[i]
		var player_info = players[player_id]
		# Spawn in line with offset distance between the 
		var spawn_position = spawn_base + Vector2(offset * i, 0)
		spawn_player.rpc(player_id, player_info, spawn_position)
	
	# Since the game start has been performed above
	# This tells other classes that the current state of game is
	# not the "game start" anymore
	is_game_start = false

## ANY CLIENT
## Adds all players in the list to the specified location
# DEPRECATED NOTE: need to pass player_list as player_location_lists.get_list_of_players(path_holder.DESIRED_PATH)
# NOTE: this function must be called after the target location scene has been loaded (e.g. in scene's _ready() function)
func spawn_all_players(player_list : Dictionary, location_path : String):
	for i in player_list.size():
		var player_id = player_list.keys()[i]
		var player_info = player_list[player_id]
		var spawn_position = spawnpoint_resolver.get_spawn_point(location_path)
		spawn_player(player_id, player_info, spawn_position)
		#most likely mistake
		#spawn_player.rpc(player_id, player_info, spawn_position)


## SERVER ONLY
@rpc("any_peer", "call_local", "reliable")
func handle_teleport_request(scene_path: String):
	# Execute on server only
	if not multiplayer.is_server():
		push_warning("Cannot call this method from Client")
		return

	var peer_id = multiplayer.get_remote_sender_id()
	var spawn_position = spawnpoint_resolver.get_spawn_point(scene_path)

	# Tell SceneManager to do the teleport
	scene_manager.teleport_player(peer_id, scene_path, spawn_position)

## CLIENT/SERVER
## This function is called from Server's player_location_list, when it removes a player from a list in its locations dictionary
## Despawns player from the get_tree().current_scene
@rpc("any_peer", "call_local", "reliable")
func despawn_player(player_id):
	var player_node = get_tree().current_scene.get_node_or_null(str(player_id))
	if player_node:
		get_tree().current_scene.remove_child(player_node)
		player_node.queue_free()
	else:
		print("[CLIENT:", multiplayer.get_unique_id(), "] Player node with ID '%s' not found." % str(player_id))
