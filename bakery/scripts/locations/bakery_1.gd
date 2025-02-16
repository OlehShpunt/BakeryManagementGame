class_name Bakery1
extends Node2D

@onready var player = scene_manager.player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# a method from Scene_manager is called that switches scenes.
	# when whis scene is loaded, it loads the current player that is located in scene_manager
	_on_scene_change()

func _on_scene_change():
	add_child(scene_manager.player)
	# Teleport to the scene's default entrance
	player.global_position = Vector2(133, 130)
