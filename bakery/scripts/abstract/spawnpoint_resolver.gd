extends Node


## Returns default spawn point for a specified location
func get_spawn_point(to_location_path: String, _from_location_path : String = "not specified") -> Vector2:
	match to_location_path:
		path_holder.STREET_PATH:
			match _from_location_path:
				# The coordinates must be slightly below the entrance to the building
				path_holder.WHOLESALE_SHOP_PATH:
					return Vector2(48, 241)
				path_holder.BAKERY_1_PATH:
					return Vector2(543, 148)
				path_holder.MINI_MARKET_PATH:
					return Vector2(830, 134)
				path_holder.SUPERMARKET_PATH:
					return Vector2(710, 677)
				path_holder.KIOSK_PATH:
					return Vector2(320, 710)
				"not specified":
					print("Spawn position not specified")
					return Vector2(200, 80) # position does not matter
				_:
					return Vector2(30, 30)
		path_holder.WHOLESALE_SHOP_PATH:
			return Vector2(132, 132) 
		path_holder.MINI_MARKET_PATH:
			return Vector2(133, 131) 
		path_holder.SUPERMARKET_PATH:
			return Vector2(135, 130) 
		path_holder.KIOSK_PATH:
			return Vector2(135, 130) 
		path_holder.BAKERY_1_PATH:
			return Vector2(133, 131) 
		_:
			return Vector2(50, 50)
