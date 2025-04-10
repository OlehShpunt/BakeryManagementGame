extends Node


func get_spawn_point(scene_path: String) -> Vector2:
	# You can expand this later per scene
	match scene_path:
		path_holder.STREET_PATH:
			return Vector2(100, 100)
		"res://scenes/cave.tscn":
			return Vector2(100, 100)
		_:
			return Vector2(50, 50)
