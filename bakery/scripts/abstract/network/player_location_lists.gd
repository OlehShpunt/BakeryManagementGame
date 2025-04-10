extends Node


signal new_locations_update


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
	
	# Update on all network peers
	rpc("update_locations", locations)


# Removes a player from a specific location
func remove_player(location_path : String, player_id : int):
	var player_info = get_player(location_path, player_id)
	locations[location_path].erase(player_id)
	
	# Update on all network peers
	rpc("update_locations", locations)
	
	return player_info


func get_player(location_path : String, player_id : int):
	if not locations.has(location_path):
		push_warning("Specified location_path is not in the locations list: ", location_path)
		return
	if locations[location_path].has(player_id):
		return locations[location_path][player_id]
	else:
		push_warning("Could not get player info (player_id: ", player_id, ") from dictionary with location key: ", location_path)
		return {}


# Fully deletes a player from the game player list
func delete_player(player_id : int):
	for location in locations:
		if locations[location].has(player_id):
			locations[location].erase(player_id)
			print("Player ID:", player_id, "removed from location:", location)
			
			# Update on all network peers
			rpc("update_locations", locations)


func get_list_of_players(location_path : String):
	if locations.has(location_path):
		return locations[location_path]
	else:
		push_warning("Specified location_path is not in the locations list")
		return null

func reset_list():
	for location in locations:
		locations[location].clear()
	
	# Update on all network peers
	rpc("update_locations", locations)


func num_of_players():
	var total = 0
	for location in locations:
		total += locations[location].size()  # Adds the number of players in each location
	return total

## Update the dictionary on all peers (synchronize data)
@rpc("any_peer", "call_remote", "reliable")
func update_locations(updated_locations: Dictionary) -> void:
	for location_path in updated_locations:
		if locations.has(location_path):
			# Replace the whole sub-dictionary for that location
			locations[location_path] = updated_locations[location_path].duplicate(true)
		else:
			push_warning("Received unknown location path: " + str(location_path))
	
	emit_signal("new_locations_update")  # unused yet
