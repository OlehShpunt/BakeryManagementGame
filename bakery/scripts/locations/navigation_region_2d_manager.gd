class_name navigation_region_2d_manager
extends NavigationRegion2D


@export var ID: int = -1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if ID < 0:
		push_error("Must have an ID specified")
		return
	
	var err = global_ref_register.register_nav_region(str(ID), self)
		
	# If OK
	if err != ERR_DUPLICATE_SYMBOL:
		call_deferred("reparent", npc_driver)
