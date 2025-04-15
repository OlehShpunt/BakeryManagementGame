extends Node


## Returns default spawn point for a specified location
func get_spawn_point(to_location_path: String, _from_location_path : String = "not specified") -> Vector2:
	match to_location_path:
		path_holder.STREET_PATH:
			match _from_location_path:
				path_holder.WHOLESALE_SHOP_PATH:
					return Vector2(50, 300)
				"not specified":
					print("Spawn position not specified")
					return Vector2(200, 80) # position does not matter
				_:
					return Vector2(30, 30)
		path_holder.WHOLESALE_SHOP_PATH:
			return Vector2(100, 90) 
		_:
			return Vector2(50, 50)
