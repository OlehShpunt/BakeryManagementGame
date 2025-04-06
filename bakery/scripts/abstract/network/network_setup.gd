extends Node

var PLAYER_SCENE = load("res://scenes/characters/player.tscn")

# Autoload named Lobby (in my case it's start_menu)

# These signals can be connected to by a UI lobby scene or the game scene.
signal player_connected(peer_id, player_info)
signal player_disconnected(peer_id)
signal server_disconnected

const PORT = 7000
const DEFAULT_SERVER_IP = "127.0.0.1" # IPv4 localhost
const MAX_CONNECTIONS = 20

# This will contain player info for every player,
# with the keys being each player's unique IDs.
var players = {}

# This is the local player info. This should be modified locally
# before the connection is made. It will be passed to every other peer.
# For example, the value of "name" can be set to something the player
# entered in a UI scene.
var player_info = {"name": "Name"}

var players_loaded = 0



func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)


# Called from start_menu when joining a player
func join_game(address = ""):
	if address.is_empty():
		address = DEFAULT_SERVER_IP
	
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(address, PORT)
	print("join_game() returned:", error)
	if error != OK:
		print("Error name:", error)
		return error
	multiplayer.multiplayer_peer = peer
	
	return OK


func create_game():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, MAX_CONNECTIONS)
	print("create_server() returned:", error)

	if error != OK:
		print("Error name:", error)
		return error

	multiplayer.multiplayer_peer = peer

	players[1] = player_info
	player_connected.emit(1, player_info)
	
	return OK


func remove_multiplayer_peer():
	multiplayer.multiplayer_peer = null
	players.clear()


# When the server decides to start the game from a UI scene,
# do Lobby.load_game.rpc(filepath)
@rpc("call_local", "reliable")
func load_game(game_scene_path):
	get_tree().change_scene_to_file(game_scene_path)


# Every peer will call this when they have loaded the game scene.
@rpc("any_peer", "call_local", "reliable")
func player_loaded():
	if multiplayer.is_server():
		players_loaded += 1
		if players_loaded == players.size():
			$/root/Game.start_game()
			players_loaded = 0


@rpc("any_peer", "reliable")
func _register_player(new_player_info):
	print("Network -> _register_player() called")
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	player_connected.emit(new_player_id, new_player_info)


# When a peer connects, send them my player info.
# This allows transfer of all desired data for each player, not only the unique ID.
func _on_player_connected(id):
	print("Network -> _on_player_connected() called")
	_register_player.rpc_id(id, player_info)


func _on_player_disconnected(id):
	print("Network -> _on_player_disconnected() called")
	players.erase(id)
	player_disconnected.emit(id)


func _on_connected_to_server():
	print("Network -> _on_connected_to_server() called")
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info
	player_connected.emit(peer_id, player_info)


func _on_connected_fail():
	print("Network -> _on_connected_fail() called")
	multiplayer.multiplayer_peer = null


func _on_server_disconnected():
	print("Network -> _on_server_disconnected() called")
	multiplayer.multiplayer_peer = null
	players.clear()
	server_disconnected.emit()


# Spawn a player on all peers
@rpc("authority", "call_local", "reliable")
func spawn_player(player_id: int, player_info: Dictionary, spawn_position: Vector2):
	print("Network -> Spawning player ", player_id, " at ", spawn_position, " on peer ", multiplayer.get_unique_id())
	var player_instance = PLAYER_SCENE.instantiate()
	player_instance.player_info = player_info
	player_instance.position = spawn_position
	player_instance.set_multiplayer_authority(player_id)
	player_instance.name = str(player_id)  # Unique name to avoid conflicts
	get_tree().current_scene.add_child(player_instance)
	print("Network -> Player ", player_id, " spawned with authority: ", player_instance.get_multiplayer_authority())


# Called by the server to spawn all players
func spawn_all_players():
	if (not multiplayer.is_server()):
		return
	
	var spawn_base = Vector2(100, 100)  # Starting position
	var offset = 50  # Space between players
	for index in players.size():
		var player_id = players.keys()[index]
		var player_info = players[player_id]
		var spawn_position = spawn_base + Vector2(offset * index, 0)
		spawn_player.rpc(player_id, player_info, spawn_position)
