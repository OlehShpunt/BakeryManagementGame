class_name npc_test
extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("&& NPC Created!!! _ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("&& NPC Running!!! _process")
