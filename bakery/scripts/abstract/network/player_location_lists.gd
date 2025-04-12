extends Node

## DEPRECATED
signal new_locations_update

signal locations_changes(locations_list)
#signal spawn_this_player(player_id, player_info)
#signal despawn_this_player(player_id)
signal list_of_players_received(player_list)


var last_requested_player_list = {"Name": "This is an initial value set in player_location_lists"}


## Holds several dictionaries used to track 
## what players are in what locations.
## Holds location paths as keys.
var locations : Dictionary = {
	path_holder.STREET_PATH : {},
	path_holder.KIOSK_PATH : {},
	path_holder.MINI_MARKET_PATH : {},
	path_holder.SUPERMARKET_PATH : {},
	path_holder.WHOLESALE_SHOP_PATH : {},
	path_holder.BAKERY_1_PATH : {}
}


@rpc("any_peer", "call_local", "reliable")
func add_player(location_path : String, player_id : int, player_info : Dictionary) -> int:
	
	# If called from Server
	if multiplayer.get_unique_id() == 1:
		
		# Invalid location path
		if not locations.has(location_path):
			push_warning("Specified location_path is not in the locations list")
			return ERR_INVALID_DATA
		
		print("[SERVER] Adding ", player_info["name"], " (id:", player_id, ") to location ", location_path)
		locations[location_path][player_id] = player_info
		
		# RPC call to all affected peers (that are in the location_path) TODO: move to another func maybe?
		for target_peer_id in locations[location_path]:
			# Don't send RPC to the peer that has been moved between scenes (the argument to this.add_player())
			if target_peer_id != player_id:
				print("[SERVER] Requesting Client with id:", target_peer_id, " to spawn player with id:", player_id, " at Client's location: ", location_path)
				var err = multiplayer_manager.rpc_id(target_peer_id, "spawn_player", player_id, player_info, spawnpoint_resolver.get_spawn_point(location_path))
				if err != OK:
					print("[SERVER] RPC spawn request failed with error code ", err)
	
	# If called from Client
	else:
		print("[CLIENT] Requesting server to add ", player_info["name"], " (id:", player_id, ") to location ", location_path)
		var err = rpc_id(1, "add_player", location_path, player_id, player_info)
		
		# If some RPC issue
		if err != OK:
			print("[CLIENT:", multiplayer.get_unique_id() ,"] Request to add id:", player_id, " to location ", location_path, " failed: error code ", err)
			return err
	
	return OK


## Removes a player from a specific location
## Returns removed player's info
@rpc("any_peer", "call_local", "reliable")
func remove_player(location_path : String, player_id : int) -> Dictionary:
	
	# If called from Server
	if multiplayer.get_unique_id() == 1:
		var player_info = get_player(location_path, player_id)
		
		print("[SERVER] Removing ", player_info["name"], " (id:", player_id, ") from location ", location_path)
		locations[location_path].erase(player_id)
		
		# RPC call to all affected peers (that are in the location_path) TODO: move to another func maybe?
		for peer_id in locations[location_path]:
			# Don't send RPC to the peer that has been moved between scenes (the argument to this.remove_player())
			if peer_id != player_id:
				print("[SERVER] Requesting id:", peer_id, " to despawn player id:", player_id, " from location: ", location_path)
				var err = multiplayer_manager.rpc_id(peer_id, "despawn_player", player_id)
				if err != OK:
					print("[SERVER] RPC despawn request failed with error code ", err)
		
		return player_info
	
	# If called from Client
	else:
		print("[CLIENT:", multiplayer.get_unique_id() ,"] Requesting server to remove id:", player_id, " from location ", location_path)
		var err = rpc_id(1, "remove_player", location_path, player_id)
		
		# If some RPC issue
		if err != OK:
			print("[CLIENT:", multiplayer.get_unique_id() ,"] Request to remove id:", player_id, " from location ", location_path, " failed: error code ", err)
			return {"name": "RPC request failed"}
		
		return {"name": "Player info was requested using RPC"}


## Returns player info of a specified player id
func get_player(location_path : String, player_id : int) -> Dictionary:
	
	# If called from Server
	if multiplayer.get_unique_id() == 1:
	
		# If invalid location
		if not locations.has(location_path): 
			push_warning("Specified location_path is not in the locations list: ", location_path)
			return {"name": "Invalid path"}
		
		# If player not in list
		if not locations[location_path].has(player_id):
			push_warning("Could not get player info (player_id: ", player_id, ") from dictionary with location key: ", location_path)
			return {"name": "Player info retrieval failed"}
		
		# All good
		return locations[location_path][player_id]
	
	# If called from Client
	else:
		push_warning("Trying to perform unsupported operation")
		return {"name": "Unsupported operation"}
		
		# TODO: this requires rpc callback/sending traffic back from the server, which I will implement later.
		#var err = rpc_id(1, "get_player", location_path, player_id)
		#
		## If some RPC issue
		#if err != OK:
			#print("[CLIENT:", multiplayer.get_unique_id() ,"] Request player info of  ", get_player(location_path, player_id)["name"], " (id:", player_id, ") from location ", location_path, " failed: error code ", err)
			#return {"name": "RPC request failed"}
		#
		#return {"name": "Player info was requested using RPC"}


##TODO: add defensive programming in this function
## SERVER ONLY
## Fully deletes a player from the game player list
func delete_player(player_id : int):
	var player_info_to_return = null
	# If Server
	if multiplayer.get_unique_id() == 1:
		for location_path in locations:
			if locations[location_path].has(player_id):
				player_info_to_return = locations[location_path][player_id]
				locations[location_path].erase(player_id)
				print("[SERVER] Client id:", player_id, " removed from location: ", location_path)
				
				# RPC call to all affected peers (that are in the location_path) TODO: move to another func maybe?
				for peer_id in locations[location_path]:
					# Don't send RPC to the peer that has been moved between scenes (the argument to this.remove_player())
					if peer_id != player_id:
						print("[SERVER] Requesting id:", peer_id, " to despawn player id:", player_id, " from location: ", location_path)
						var err = multiplayer_manager.rpc_id(peer_id, "despawn_player", player_id)
						if err != OK:
							print("[SERVER] RPC despawn request failed wit error code ", err)
				
				return player_info_to_return
	# If Client
	else:
		push_warning("Cannot call this function from Client")


## Can be called from either Server or Client. In both cases calls RPCs (if Server - RPC to itself)
## RPC function to get the list of players
@rpc("any_peer", "call_remote")
func get_list_of_players(location_path: String):
	
	# If called by Server
	if multiplayer.get_unique_id() == 1:
		list_of_players_received.emit(locations[location_path])
		return
	
	# Continue if called by Client
	var caller_id = multiplayer.get_remote_sender_id()
	
	if locations.has(location_path):
		# Send the result back to the caller
		print("[SERVER] Sending list of players back to id:", caller_id)
		rpc_id(caller_id, "receive_list_of_players", locations[location_path])
	
	else:
		push_warning("Specified location_path is not in the locations list")
		# Send null back to the caller
		rpc_id(caller_id, "receive_list_of_players", null)


## Client-side function to receive the list of players
## Called from Server only in get_list_of_players
## Emits signal when player list received
# NOTE: This function requires the receiver to keep a local variable that holds the received value. 
# TODO: Replace with raw byte sending, and receiving using signals
@rpc("any_peer", "call_remote")
func receive_list_of_players(player_list):
	if player_list == null:
		print("[CLIENT:", multiplayer.get_unique_id(), "] Requested list of players is null")
		list_of_players_received.emit({"name": "Requested list is empty (null)"})
	else:
		print("[CLIENT:", multiplayer.get_unique_id(), "] Received player list: ", player_list)
		list_of_players_received.emit(player_list)


## This function is an alternative to the get_list_of_players() (RPC version).
## It must be called from Server only.
## This function returns the player list directly without RPC, since the data is at this dedicated game client (well, server)
func get_list_of_players__CALL_FROM_SERVER(location_path : String) -> Dictionary:
	# Additional validation
	if not multiplayer.is_server():
		push_error("This function can be strictly used from server only")
	
	return locations[location_path]


## Should normally be called by Server only
func reset_list():
	if multiplayer.get_unique_id() == 1:
		print("[SERVER] Resetting locations dictionary...")
		for location in locations:
			locations[location].clear()
	else:
		push_warning("Cannot call from Client")


## SERVER ONLY
## Returns number of players in locations dictionary
func num_of_players():
	if multiplayer.get_unique_id() == 1:
		var total = 0
		for location in locations:
			total += locations[location].size()  # Adds the number of players in each location
		return total
	
	else:
		push_warning("Cannot call this function from Client")


## DEPRECATED: Data is stored on Server only now
## Update the dictionary on all peers (synchronize data)
@rpc("any_peer", "call_remote", "reliable")
func update_locations(_updated_locations: Dictionary) -> void:
	
	push_warning("Trying to perform unsupported operation")
	
	#for location_path in updated_locations:
		#if locations.has(location_path):
			## Replace the whole sub-dictionary for that location
			#locations[location_path] = updated_locations[location_path].duplicate(true)
		#else:
			#push_warning("Received unknown location path: " + str(location_path))
	#
	#emit_signal("new_locations_update")  # unused yet


## TODO: to remove (debug function)
func print_dict_contents(dict: Dictionary, indent := 0) -> void:
	for key in dict.keys():
		var value = dict[key]
		var prefix = "  ".repeat(indent)
		print(prefix, key, ": ", value)
		
		if typeof(value) == TYPE_DICTIONARY:
			print_dict_contents(value, indent + 1)
