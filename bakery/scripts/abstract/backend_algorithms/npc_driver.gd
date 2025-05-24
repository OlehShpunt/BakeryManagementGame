extends Node


var npc_customer_inst = preload("res://scenes/npc/npc_customer.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("&& NPC Driver started! ")


func add_npc_customer():
	var npc = npc_customer_inst.instantiate()
	
	npc.path = [
		global_ref_register.get_path_point_ref(20).get_rand_coordinate(),
		global_ref_register.get_path_point_ref(14).get_rand_coordinate(),
		global_ref_register.get_path_point_ref(7).get_rand_coordinate(),
		global_ref_register.get_path_point_ref(6).get_rand_coordinate(),
		global_ref_register.get_path_point_ref(1).get_rand_coordinate()
	]
	
	npc.global_position = npc.path[-1]
	
	add_child(npc)
