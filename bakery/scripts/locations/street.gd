class_name Street
extends Node2D

var player = scene_manager.player

var street = load("res://scenes/locations/street.tscn")
var bakery_1 = load("res://scenes/locations/bakery_1.tscn")
var supermarket = load("res://scenes/locations/supermarket.tscn")
var mini_market = load("res://scenes/locations/mini_market.tscn")
var kiosk = load("res://scenes/locations/kiosk.tscn")
var wholesale_shop = load("res://scenes/locations/wholesale_shop.tscn")

var first_load_player = preload("res://scenes/characters/player.tscn")

func _ready() -> void:
	if (scene_manager.first_load == true):
		on_first_load()
	else:
		add_child(scene_manager.player)
		if (scene_manager.previous_scene == bakery_1):
			player.global_position = Vector2($Teleports/TeleportBakery1.global_position.x, $Teleports/TeleportBakery1.global_position.y + 20)
		elif (scene_manager.previous_scene == supermarket):
			player.global_position = Vector2($Teleports/TeleportSupermarket.global_position.x, $Teleports/TeleportSupermarket.global_position.y + 20)
		elif (scene_manager.previous_scene == mini_market):
			player.global_position = Vector2($Teleports/TeleportMiniMarket.global_position.x, $Teleports/TeleportMiniMarket.global_position.y + 20)
		elif (scene_manager.previous_scene == kiosk):
			player.global_position = Vector2($Teleports/TeleportKiosk.global_position.x, $Teleports/TeleportKiosk.global_position.y + 20)
		elif (scene_manager.previous_scene == wholesale_shop):
			player.global_position = Vector2($Teleports/TeleportWholesaleShop.global_position.x, $Teleports/TeleportWholesaleShop.global_position.y + 20)
		else:
			pass
			push_error("Could not move Player to coordinates, because previous_scene in scene_manager is null")

# Called when the scene is loaded for the first time
# Since there's no player node in the street scene, it
# needs to add the player.
func on_first_load():
	scene_manager.first_load = false
	var p : Player = first_load_player.instantiate()
	self.add_child(p)
	scene_manager.player = p
	player = p
	player.global_position = Vector2(200, 85)
