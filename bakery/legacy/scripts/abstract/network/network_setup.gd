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

## This will contain player info for every player,
## with the keys being each player's unique IDs.
#var players = {}

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
	print("{NETWORK_SETUP} join_game() returned:", error)
	if error != OK:
		print("{NETWORK_SETUP} Error name:", error)
		return error
	multiplayer.multiplayer_peer = peer
	
	return OK


func create_game():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, MAX_CONNECTIONS)
	print("{NETWORK_SETUP} create_server() returned:", error)
	
	# TODO refactoring
	if error != OK:
		print("{NETWORK_SETUP} Error name:", error)
		return error

	multiplayer.multiplayer_peer = peer

	player_location_lists.add_player(path_holder.STREET_PATH, 1, player_info)
	
	player_connected.emit(1, player_info)  # unused
	
	return OK


func remove_multiplayer_peer():
	# Disable multiplayer networking system and terminate connection between peers
	multiplayer.multiplayer_peer = null
	# Remove players from the list. Useful when game is over.
	player_location_lists.reset_list()


# When the server decides to start the game from a UI scene,
# do Lobby.load_game.rpc(filepath)
@rpc("call_local", "reliable")
func load_game(game_scene_path):
	get_tree().change_scene_to_file(game_scene_path)
	seller_item_list_generator.generate_item_list_for_all_sellers()
	player_location_lists.print_dict_contents(player_location_lists.locations)


# new_player_info must be specified before connecting a player using join/host
# the join()/host() caller must specify new_player_info by directly accessing it
# using this class (i.g. network_setup.player_info["name"] = "TheName")
# the player_info is added to each peer's players dictionary
## Register in the player Dictionary
@rpc("any_peer", "reliable")
func _register_player(new_player_info):
	print("{NETWORK_SETUP} _register_player() called")
	var new_player_id = multiplayer.get_remote_sender_id()  # get peer id
	player_location_lists.add_player(path_holder.STREET_PATH, new_player_id, new_player_info)
	player_connected.emit(new_player_id, new_player_info)  # unused


# When a peer connects, send them my player info.
# This allows transfer of all desired data for each player, not only the unique ID.
func _on_player_connected(id):
	print("{NETWORK_SETUP} _on_player_connected() called")
	# Call rpc on specific multiplayer peer using its id
	_register_player.rpc_id(id, player_info)


## SERVER ONLY
func _on_player_disconnected(id):
	print("{NETWORK_SETUP} _on_player_disconnected() called")
	player_location_lists.delete_player(id)
	player_disconnected.emit(id)


func _on_connected_to_server():
	print("{NETWORK_SETUP} _on_connected_to_server() called")
	var peer_id = multiplayer.get_unique_id()
	player_location_lists.add_player(path_holder.STREET_PATH, peer_id, player_info)
	player_connected.emit(peer_id, player_info)  # unused


func _on_connected_fail():
	print("{NETWORK_SETUP} _on_connected_fail() called")
	multiplayer.multiplayer_peer = null


func _on_server_disconnected():
	print("{NETWORK_SETUP} _on_server_disconnected() called")
	multiplayer.multiplayer_peer = null
	player_location_lists.reset_list()
	server_disconnected.emit()


## NOTE: unused yet
## Every peer will call this when they have loaded the game scene.
#@rpc("any_peer", "call_local", "reliable")
#func player_loaded():
	#if multiplayer.is_server():
		#players_loaded += 1
		#if players_loaded == players.size():
			#$/root/Game.start_game()
			#players_loaded = 0
