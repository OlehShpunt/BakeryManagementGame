extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("&& NPC Driver started! ")
	add_child(npc_test.new())
	add_child(npc_test.new())
	add_child(npc_test.new())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
