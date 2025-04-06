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
		network_setup.spawn_all_players()
	
	#if (scene_manager.first_load == true):
		#on_first_load()
	#else:
		#add_child(scene_manager.player)
		##TODO: rewrite this garbage - put in a function in scene_manager, or rewrite the logic
		#if (scene_manager.previous_scene == bakery_1):
			#player.global_position = Vector2($Teleports/TeleportBakery1.global_position.x, $Teleports/TeleportBakery1.global_position.y + 20)
		#elif (scene_manager.previous_scene == supermarket):
			#player.global_position = Vector2($Teleports/TeleportSupermarket.global_position.x, $Teleports/TeleportSupermarket.global_position.y + 20)
		#elif (scene_manager.previous_scene == mini_market):
			#player.global_position = Vector2($Teleports/TeleportMiniMarket.global_position.x, $Teleports/TeleportMiniMarket.global_position.y + 20)
		#elif (scene_manager.previous_scene == kiosk):
			#player.global_position = Vector2($Teleports/TeleportKiosk.global_position.x, $Teleports/TeleportKiosk.global_position.y + 20)
		#elif (scene_manager.previous_scene == wholesale_shop):
			#player.global_position = Vector2($Teleports/TeleportWholesaleShop.global_position.x, $Teleports/TeleportWholesaleShop.global_position.y + 20)
		#else:
			#pass
			#push_error("Could not move Player to coordinates, because previous_scene in scene_manager is null")

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

func add_players():
	for id in network_setup.players:
		print("Network -> Adding ", id)
		var info = network_setup.players[id]
		var player_instance = PLAYER_SCENE.instantiate()
		
		# Pass player info to the instance
		player_instance.player_info = info
		
		# Position the player somewhere (this is just an example)
		player_instance.position = Vector2(100, 100) 
		
		# Set network ownership so only the owner can control it
		player_instance.set_multiplayer_authority(id)

		add_child(player_instance)
