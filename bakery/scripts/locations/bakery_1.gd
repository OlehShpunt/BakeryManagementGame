class_name Bakery1
extends InsideLocationBase


func get_location_path():
	print("------------>>>>>>>>> THIS DAMN CORRECT FUNC WAS CALLED")
	return path_holder.BAKERY_1_PATH

func _ready() -> void:
	player_location_lists.list_of_players_received.connect(_on_list_of_players_received)
	# Request for player_list
	player_location_lists.get_list_of_players(get_location_path())


## Called when the requested player list arrives
func _on_list_of_players_received(player_list):
	print("--------->>>>>>>>>>> DAMN PLAYER LIST:", player_list)
	# Polymorphism
	multiplayer_manager.spawn_all_players(player_list, get_location_path())


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
