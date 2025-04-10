class_name InsideLocationBase
extends Node2D


func _ready() -> void:
	# Polymorphism
	multiplayer_manager.spawn_all_players(player_location_lists.get_list_of_players(get_location_path()), get_location_path())

# NOTE: You must override get_location_path() in the child class that extends InsideLocationBase
func get_location_path():
	push_error("You must override get_location_path() in the child class that extends InsideLocationBase")
	return "Override this method in child class"


#@onready var player = scene_manager.player
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	## a method from Scene_manager is called that switches scenes.
	## when whis scene is loaded, it loads the current player that is located in scene_manager
	#_on_scene_change()
#
#func _on_scene_change():
	#add_child(scene_manager.player)
	## Teleport to the scene's default entrance
	#player.global_position = Vector2($Teleport.global_position.x, $Teleport.global_position.y - 30)
