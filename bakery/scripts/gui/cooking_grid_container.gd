extends GridContainer

@export var resource = preload("res://resources/gui/cooking_gui_resource.tres")

func _ready() -> void:
	pass
	#for i in range(9):
		#if get_child(i) != $Arrow:
			#get_child(i).resource = self.resource

func get_resource():
	return self.resource
