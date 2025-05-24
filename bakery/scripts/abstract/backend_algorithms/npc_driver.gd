extends Node


var npc_customer_inst = preload("res://scenes/npc/npc_customer.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var custom_path = []
	
	print("&& NPC Driver started! ")
	
	var npc = npc_customer_inst.instantiate()
	
	npc.path = [Vector2(100,52), Vector2(100,100), Vector2(120,170), Vector2(200, 30)]
	
	add_child(npc)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
