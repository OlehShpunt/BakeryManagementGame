class_name Street
extends Node2D

var player = scene_manager.player

var street = load("res://scenes/locations/street.tscn")
var bakery_1 = load("res://scenes/locations/bakery_1.tscn")
var supermarket = load("res://scenes/locations/supermarket.tscn")
var mini_market = load("res://scenes/locations/mini_market.tscn")
var kiosk = load("res://scenes/locations/kiosk.tscn")
var wholesale_shop = load("res://scenes/locations/wholesale_shop.tscn")
var PLAYER_SCENE = load("res://scenes/characters/player.tscn")

var first_load_player = preload("res://scenes/characters/player.tscn")

func _ready() -> void:
	print("Network -> _ready() on peer: ", multiplayer.get_unique_id())
	if multiplayer.is_server():
		multiplayer_manager.spawn_players_on_game_start()
