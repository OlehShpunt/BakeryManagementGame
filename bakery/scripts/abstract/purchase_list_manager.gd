extends Node


func get_list(round: int):
	var file = FileAccess.open("res://resources/json/purchase_lists.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	var all = data["rounds"][str(round)]
	
	var num = randi_range(0, 5)
	
	var list = all[str(num)]
	
	for i in range(list.size()):
		list[i] = path_holder.INGR_DIR_PATH + list[i] + path_holder.SCENE_EXT
	
	return list
