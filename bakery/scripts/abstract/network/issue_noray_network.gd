extends Node

signal SIGNAL_connected_to_noray(oid : String)

const HOST_ADDRESS = "tomfol.io"
const PORT = 8890

var external_oid = "empty oid"

var err = OK

var is_host = false

var active_oid = "no oid yet"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Noray Network -> [_ready()] OID: ", Noray.oid)
	Noray.on_connect_relay.connect(_handle_on_connect_relay)
	Noray.on_connect_nat.connect(_handle_on_connect_nat)


func host_game():
	await connect_to_noray()
	
	var peer = ENetMultiplayerPeer.new()
	var err = peer.create_server(Noray.local_port)
	get_tree().get_multiplayer().multiplayer_peer = peer
	
	if err != OK:
		print("Noray Network -> Hosting failed")
		return err # Failed to listen on port
	print("Noray Network -> Hosting successfull")
	is_host = true


func join_game(oid):
	print("Noray Network -> Joining with OID ", oid)
	if !is_host:
		external_oid = oid
		
		var err = await Noray.connect_nat(oid)
		print("Noray Network -> Error value when joining: ", err)
	else:
		print("Noray Network -> Cannot join. Already a host.")
	

func _handle_on_connect_nat(address, port):
	print("Noray Network -> _handle_on_connect_nat() called, handling NAT...")
	if (await connect_to_server(address, port)) != OK && !is_host: # if nat coonnection failed, connect relay
		print("Noray Network -> NAT failed. Trying Relay.")
		
		var err_c = await Noray.connect_relay(external_oid)
		
		if err_c != OK:
			print("Noray Network -> Relay connection failed.")
			return FAILED
	return OK


func _handle_on_connect_relay(address, port):
	print("Noray Network -> _handle_on_connect_relay() called, handling NAT...")
	return await connect_to_server(address, port)


## Executed while handling nat and relay signals
func connect_to_server(address: String, port: int) -> Error:
	
	print("Start Menu -> connect_to_server() called")
	
	if is_host: # host
		
		var peer = get_tree().get_multiplayer().multiplayer_peer as ENetMultiplayerPeer
		var err = await PacketHandshake.over_enet(peer.host, address, port)
		
		if err != OK:
			print("Noray Network -> handshake failed (host)")
			return err
			
		print("Noray Network -> handshake successfull (host)")
		
		return OK
		
	else: # joiner
		
		# Do a handshake
		var udp = PacketPeerUDP.new()
		udp.bind(Noray.local_port)
		udp.set_dest_address(address, port)
		
		var err = await PacketHandshake.over_packet_peer(udp)
		udp.close()
		
		if err != OK:
			print("Noray Network -> handshake failed (joiner)")
			return err
		print("Noray Network -> handshake successfull (joiner)")
			
		# Connect to host
		var peer = ENetMultiplayerPeer.new()
		err = peer.create_client(address, port, 0, 0, 0, Noray.local_port)
		
		if err != OK:
			print("Noray Network -> client creation failed (joiner)")
			return err
		
		print("Noray Network -> client creation successfull (joiner)")
		
		return OK


## Connects to the server and saves info to Noray (oid, pid, local_port etc.)
func connect_to_noray():
	# Connect to noray
	err = await Noray.connect_to_host(HOST_ADDRESS, PORT)
	if err != OK:
		print("Noray Network -> failed to connect to host: ", err) # Failed to connect
		return err
		
	# Register host
	Noray.register_host()
	await Noray.on_pid
	
	# Debug
	active_oid = Noray.oid
	print("Noray Network -> ", active_oid)
	
	# Register remote address
	# This is where noray will direct traffic
	err = await Noray.register_remote()
	if err != OK:
		print("Noray Network -> failed to connect to host: ", err) # Failed to connect
		return err
		
	SIGNAL_connected_to_noray.emit(Noray.oid)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
