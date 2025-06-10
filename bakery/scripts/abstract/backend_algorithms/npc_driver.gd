extends Node


var npc_customer_inst = preload("res://scenes/npc/npc_customer.tscn")
var npc_base_inst = preload("res://scenes/npc/npc_base.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("&& NPC Driver started! ")


func add_npc_base():
	var target_pos = Vector2(545, 150)
	
	var npc : npc_base = npc_base_inst.instantiate()
	npc.buffered_target_position = target_pos
	npc.global_position = Vector2(45, 55)
	add_child(npc)


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
