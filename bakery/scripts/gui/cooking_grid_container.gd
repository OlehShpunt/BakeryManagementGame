extends GridContainer

@export var resource = preload("res://resources/gui/cooking_gui_resource.tres")

func _ready() -> void:
	for i in range(9):
		if get_child(i) != $Arrow:
			get_child(i).resource = resource
