class_name WebSocketClient
extends Node

# The URL we will connect to.
# Use "ws://localhost:9080" if testing with the minimal server example below.
# `wss://` is used for secure connections,
# while `ws://` is used for plain text (insecure) connections.
var websocket_url := "ws://localhost:5000"

# Our WebSocketClient instance.
var socket := WebSocketPeer.new()

# Connected to server's web sockets
var connected := false
var joined_lobby := false
var player_name := ""

# Events
signal player_joined_lobby(id: String, name: String)


func setup(player_name_param: String) -> void:
	# Initiate connection to the given URL.
	var err := socket.connect_to_url(websocket_url)
	if err == OK:
		print("Connecting to %s..." % websocket_url)
		# Wait for the socket to connect.
		await get_tree().create_timer(2).timeout

		self.player_name = player_name_param

		connected = true
	else:
		push_error("Unable to connect.")
		set_process(false)


func _process(_delta: float) -> void:
	if not connected:
		return

	socket.poll()
	var state := socket.get_ready_state()

	if state == WebSocketPeer.STATE_OPEN:
		# Join the main lobby
		if not joined_lobby:
			send_add_to_lobby(self.player_name)
			joined_lobby = true

		while socket.get_available_packet_count():
			var packet := socket.get_packet()
			if socket.was_string_packet():
				var packet_text := packet.get_string_from_utf8()
				print("< Got text data from server: %s" % packet_text)
			else:
				handle_inbound_message(packet) # Handle binary data

	# `WebSocketPeer.STATE_CLOSING` means the socket is closing.
	# It is important to keep polling for a clean close.
	elif state == WebSocketPeer.STATE_CLOSING:
		pass

	# `WebSocketPeer.STATE_CLOSED` means the connection has fully closed.
	# It is now safe to stop polling.
	elif state == WebSocketPeer.STATE_CLOSED:
		# The code will be `-1` if the disconnection was not properly notified by the remote peer.
		var code := socket.get_close_code()
		print("WebSocket closed with code: %d. Clean: %s" % [code, code != -1])
		set_process(false) # Stop processing.


func send_add_to_lobby(player_name_param: String) -> void:
	var writer := StreamPeerBuffer.new()
	writer.put_16(1) # Action code for AddNewPlayerToLobby
	writer.put_data(player_name_param.to_ascii_buffer()) # Write player name as a string
	socket.put_packet(writer.data_array)
	print("> Sent AddNewPlayerToLobby with name: ", player_name_param)


func send_remove_from_lobby() -> void:
	var writer := StreamPeerBuffer.new()
	writer.put_16(2) # Action code for RemovePlayerFromLobby
	socket.put_packet(writer.data_array)
	print("> Sent RemovePlayerFromLobby")


func send_move_player(x: int, y: int) -> void:
	var writer := StreamPeerBuffer.new()
	writer.put_16(4) # Action code for MovePlayer
	writer.put_float(x) # Write x coordinate as float
	writer.put_float(y) # Write y coordinate as float
	socket.put_packet(writer.data_array)
	print("> Sent MovePlayer")


func send_teleport_player(x: int, y: int, scene_id: int) -> void:
	var writer := StreamPeerBuffer.new()
	writer.put_16(3) # Action code for TeleportPlayer
	writer.put_float(x) # Write x coordinate as float
	writer.put_float(y) # Write y coordinate as float
	writer.put_16(scene_id) # Write scene ID as Int16
	socket.put_packet(writer.data_array)
	print("> Sent TeleportPlayer")


# TODO: use ASCII everywhere
func handle_inbound_message(packet: PackedByteArray) -> void:
	var reader := StreamPeerBuffer.new()
	reader.data_array = packet

	var action_code := reader.get_16() # Read the action code
	match action_code:
		1: # PlayerJoinedLobby
			var player_id := reader.get_string(36) # Read fixed-length GuidString36
			var remaining_bytes := reader.data_array.size() - reader.get_position()
			var p_name: String = reader.get_string(remaining_bytes) # Read player name
			print("Player Name: %s" % p_name)
			Console.print_info("< PlayerJoinedLobby: %s, %s" % [player_id, p_name])
			player_joined_lobby.emit(player_id, p_name)
		2: # PlayerLeftLobby
			var player_id := reader.get_string(36) # Read fixed-length GuidString36
			Console.print_info("< PlayerLeftLobby: %s" % player_id)
			# TODO: Pass `player_id` to another layer for processing
		3: # PlayerMoved
			var player_id := reader.get_string(36) # Read fixed-length GuidString36
			var x: float = reader.get_float()
			var y: float = reader.get_float()
			Console.print_info("< PlayerMoved: %s, x: %f, y: %f" % [player_id, x, y])
			# TODO: Pass `player_id`, `x`, and `y` to another layer for processing
		4: # PlayerTeleported
			var player_id := reader.get_string(36) # Read fixed-length GuidString36
			var x: float = reader.get_float()
			var y: float = reader.get_float()
			var scene_id: int = reader.get_16()
			Console.print_info("< PlayerTeleported: %s, x: %f, y: %f, scene: %d" % [player_id, x, y, scene_id])
			# TODO: Pass `player_id`, `x`, `y`, and `scene_id` to another layer for processing
		5: # Error
			var remaining_bytes := reader.data_array.size() - reader.get_position()
			var error_message := reader.get_string(remaining_bytes)
			Console.print_info("< Error: %s" % error_message)
		6: # Success
			var remaining_bytes := reader.data_array.size() - reader.get_position()
			var success_message: String = reader.get_string(remaining_bytes)
			Console.print_info("< Success: %s" % success_message)
		_:
			Console.print_info("< Unknown action code: %d" % action_code)
