@tool
extends Node
class_name PathPicker


static var PATH_HOLDER = path_holder


@export var selected_option := ""


func _get_property_list():
	var props = []
	props.append({
		"name": "selected_option",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": get_constant_names().join(","),
		"usage": PROPERTY_USAGE_DEFAULT,
	})
	return props

static func get_constant_names():
	var list := []
	
	var prop_list = PATH_HOLDER.get_script().get_script_property_list()
	
	for name in prop_list:
		if prop_list.has_constant(name):
			list.append(prop_list.get(name))
	return list
