class_name Street
extends Node2D

var first_load_player = preload("res://scenes/characters/player.tscn")
var PATH = path_holder.STREET_PATH


func _ready() -> void:
	
	player_location_lists.list_of_players_received.connect(_on_list_of_players_received)
	player_location_lists.get_list_of_players(path_holder.STREET_PATH)
	
	# TEST
	npc_driver.add_npc_base()


func _on_list_of_players_received(player_list):
	
	# ON GAME START - SERVER ONLY
	if multiplayer_manager.is_game_start:
		if multiplayer.is_server():
			print("[SERVER:", multiplayer.get_unique_id(), "] Street _ready() called on game start")
			multiplayer_manager.spawn_players_on_game_start(player_list)
	
	# NOT ON GAME START - CLIENT/SERVER
	else:
		print("[CLIENT:", multiplayer.get_unique_id(), "] Street _ready() called not on game start")
		multiplayer_manager.spawn_all_players(player_list, spawnpoint_resolver.get_spawn_point(get_location_path()))


func get_location_path():
	return path_holder.STREET_PATH
