extends Node


## Returns default spawn point for a specified location
func get_spawn_point(to_location_path: String, _from_location_path : String = "not specified") -> Vector2:
	
	match to_location_path:
		path_holder.STREET_PATH:
			
			match _from_location_path:
				# The coordinates must be slightly below the entrance to the building
				path_holder.WHOLESALE_SHOP_PATH:
					return Vector2(95, 422)
				path_holder.BAKERY_1_PATH:
					return Vector2(1007, 559)
				path_holder.MINI_MARKET_PATH:
					return Vector2(1777, 172)
				path_holder.SUPERMARKET_PATH:
					return Vector2(1392, 1446)
				path_holder.KIOSK_PATH:
					return Vector2(530, 1545)
				"not specified":
					print("Spawn position not specified")
					return Vector2(200, 80) # position does not matter
				_:
					return Vector2(30, 30)
		
		path_holder.WHOLESALE_SHOP_PATH:
			return Vector2(132, 128) 
		path_holder.MINI_MARKET_PATH:
			return Vector2(133, 128) 
		path_holder.SUPERMARKET_PATH:
			return Vector2(135, 128) 
		path_holder.KIOSK_PATH:
			return Vector2(495, 275) 
		path_holder.BAKERY_1_PATH:
			return Vector2(496, 275) 
		_:
			return Vector2(50, 50)
