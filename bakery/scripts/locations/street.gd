class_name Street
extends Node2D


var player = scene_manager.player


# TODO: delete this, but check if anything depends on it
var street = load("res://scenes/locations/street.tscn")
var bakery_1 = load("res://scenes/locations/bakery_1.tscn")
var supermarket = load("res://scenes/locations/supermarket.tscn")
var mini_market = load("res://scenes/locations/mini_market.tscn")
var kiosk = load("res://scenes/locations/kiosk.tscn")
var wholesale_shop = load("res://scenes/locations/wholesale_shop.tscn")
var PLAYER_SCENE = load("res://scenes/characters/player.tscn")


var first_load_player = preload("res://scenes/characters/player.tscn")


func _ready() -> void:
	var state_msg = "NOT ON GAME START"
	if multiplayer_manager.is_game_start:
		state_msg = "ON GAME START, BUT SPAWNING WILL BE PERFORMED FROM SERVER, NOT HERE"
		
	player_location_lists.list_of_players_received.connect(_on_list_of_players_received)
	
	print("[CLIENT:", multiplayer.get_unique_id(), "] Street _ready() called ", state_msg)
	
	player_location_lists.get_list_of_players(path_holder.STREET_PATH)


func _on_list_of_players_received(player_list):
	
	# ON GAME START - SERVER ONLY
	if multiplayer_manager.is_game_start:
		if multiplayer.is_server():
			multiplayer_manager.spawn_players_on_game_start(player_list)
	
	# NOT ON GAME START - CLIENT/SERVER
	else:
		multiplayer_manager.spawn_all_players(player_list, get_location_path())


func get_location_path():
	return path_holder.STREET_PATH
