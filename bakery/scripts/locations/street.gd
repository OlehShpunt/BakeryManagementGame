class_name Street
extends Node2D

var player = scene_manager.player
var street = load("res://scenes/locations/street.tscn")
var bakery_1 = load("res://scenes/locations/bakery_1.tscn")
var shop_1 = load("res://scenes/locations/shop_1.tscn")
var first_load_player = preload("res://scenes/characters/player.tscn")

func _ready() -> void:
	if (scene_manager.first_load == true):
		on_first_load()
	else:
		add_child(scene_manager.player)
		if (scene_manager.previous_scene == bakery_1):
			player.global_position = Vector2(150, 120)
		elif (scene_manager.previous_scene == shop_1):
			player.global_position = Vector2(325, 425)
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
	player.global_position = Vector2(200, 100)
