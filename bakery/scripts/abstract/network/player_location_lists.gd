extends Node


# Holds several dictionaries used to track 
# what players are in what locations
# Holds location paths as keys
var locations : Dictionary = {
	path_holder.STREET_PATH : {},
	path_holder.KIOSK_PATH : {},
	path_holder.MINI_MARKET_PATH : {},
	path_holder.SUPERMARKET_PATH : {},
	path_holder.WHOLESALE_SHOP_PATH : {},
	path_holder.BAKERY_1_PATH : {}
}


func add_player(location_path : String, player_id : int, player_info : Dictionary):
	if not locations.has(location_path):
		push_warning("Specified location_path is not in the locations list")
		return
	
	locations[location_path][player_id] = player_info


# Removes a player from a specific location
func remove_player(location_path : String, player_id : int):
	locations[location_path].erase(player_id)


# Removes a player from the game player list
func delete_player(player_id : int):
	for location in locations:
		if locations[location].has(player_id):
			locations[location].erase(player_id)
			print("Player ID:", player_id, "removed from location:", location)


func get_list_of_players(location_path : String):
	if locations[location_path]:
		return locations[location_path]
	else:
		push_warning("invalid location_path value")
		return null

func reset_list():
	for location in locations:
		location.clear()


func num_of_players():
	var total = 0
	for location in locations:
		total += locations[location].size()  # Adds the number of players in each location
	return total
