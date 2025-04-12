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
	
	player_location_lists.list_of_players_received.connect(_on_list_of_players_received)
	
	print("Street _ready() on peer: ", multiplayer.get_unique_id())
	if multiplayer.is_server():
		player_location_lists.get_list_of_players(path_holder.STREET_PATH)


func _on_list_of_players_received(player_list):
	multiplayer_manager.spawn_players_on_game_start(player_list)


func get_location_path():
	return path_holder.STREET_PATH
