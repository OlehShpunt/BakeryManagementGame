extends Node

var PLAYER_SCENE = load("res://scenes/characters/player.tscn")

# Spawn a player on all peers
@rpc("authority", "call_local", "reliable")
func spawn_player(player_id: int, player_info: Dictionary, spawn_position: Vector2):
	
	var player_instance = PLAYER_SCENE.instantiate()
	
	print("Network -> Spawning player ", player_id, " at ", spawn_position, " on peer ", multiplayer.get_unique_id())
	
	player_instance.player_info = player_info
	player_instance.position = spawn_position
	player_instance.set_multiplayer_authority(player_id)
	player_instance.name = str(player_id)  # Unique name to avoid conflicts
	
	get_tree().current_scene.add_child(player_instance)
	
	print("Network -> Player ", player_id, " spawned with authority: ", player_instance.get_multiplayer_authority(), "(Player name: )", player_info["name"])


## Adds all players in the list to the current scene node
## Use this method from host client (server) only.
## Use before the game starts only.
func spawn_players_on_game_start(players = player_location_lists.get_list_of_players(path_holder.STREET_PATH)):
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

## ON SERVER ONLY
@rpc("reliable")
func handle_teleport_request(scene_path: String):
	# Execute on server only
	if not multiplayer.is_server():
		return

	var peer_id = multiplayer.get_remote_sender_id()
	var spawn_position = spawnpoint_resolver.get_spawn_point(scene_path)

	# Tell SceneManager to do the teleport
	scene_manager.teleport_player(peer_id, scene_path, spawn_position)
