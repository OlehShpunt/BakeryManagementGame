extends Node

signal SIGNAL_connected_to_noray(oid: String)

const HOST_ADDRESS = "tomfol.io"
const PORT = 8890

var external_oid = "empty oid"
var err = OK
var is_host = false
var active_oid = "no oid yet"

func _ready() -> void:
	print("Noray Network -> [_ready()] OID: ", Noray.oid)
	Noray.on_connect_relay.connect(_handle_on_connect_relay)
	Noray.on_connect_nat.connect(_handle_on_connect_nat)

func host_game():
	await connect_to_noray()
	var peer = ENetMultiplayerPeer.new()
	err = peer.create_server(Noray.local_port)
	if err != OK:
		print("Noray Network -> Hosting failed: ", err)
		return err
	get_tree().get_multiplayer().multiplayer_peer = peer
	print("Noray Network -> Hosting successful on port ", Noray.local_port)
	is_host = true
	return OK

func join_game(oid):
	print("Noray Network -> Joining with OID ", oid)
	if is_host:
		print("Noray Network -> Cannot join. Already a host.")
		return
	if oid == Noray.oid and Noray.oid != "":
		print("Noray Network -> Error: Cannot join your own OID!")
		return
	external_oid = oid
	# Minimal setup: connect to Noray server without registering as host
	err = await Noray.connect_to_host(HOST_ADDRESS, PORT)
	if err != OK:
		print("Noray Network -> Failed to connect to Noray server: ", err)
		return err
	# Register remote port for joiner (required for handshake)
	err = await Noray.register_remote()
	if err != OK:
		print("Noray Network -> Failed to register remote: ", err)
		return err
	print("Noray Network -> Joiner registered with local_port: ", Noray.local_port)
	err = await Noray.connect_nat(oid)
	if err != OK:
		print("Noray Network -> NAT connection failed: ", err)
		return err
	print("Noray Network -> NAT connection initiated successfully")
	return OK

func _handle_on_connect_nat(address, port):
	print("Noray Network -> _handle_on_connect_nat() called, handling NAT to ", address, ":", port)
	return await connect_to_server(address, port)

func _handle_on_connect_relay(address, port):
	print("Noray Network -> _handle_on_connect_relay() called to ", address, ":", port)
	return await connect_to_server(address, port)

func connect_to_server(address: String, port: int) -> Error:
	print("Noray Network -> connect_to_server() called: ", address, ":", port)
	if is_host:
		var peer = get_tree().get_multiplayer().multiplayer_peer as ENetMultiplayerPeer
		err = await PacketHandshake.over_enet(peer.host, address, port)
		if err != OK:
			print("Noray Network -> Handshake failed (host): ", err)
			return err
		print("Noray Network -> Handshake successful (host)")
		return OK
	else:
		var udp = PacketPeerUDP.new()
		err = udp.bind(Noray.local_port)
		if err != OK:
			print("Noray Network -> UDP bind failed: ", err)
			udp.close()
			return err
		udp.set_dest_address(address, port)
		err = await PacketHandshake.over_packet_peer(udp)
		udp.close()
		if err != OK:
			print("Noray Network -> Handshake failed (joiner): ", err)
			return err
		print("Noray Network -> Handshake successful (joiner)")
		var peer = ENetMultiplayerPeer.new()
		err = peer.create_client(address, port, 0, 0, 0, Noray.local_port)
		if err != OK:
			print("Noray Network -> Client creation failed (joiner): ", err)
			return err
		get_tree().get_multiplayer().multiplayer_peer = peer
		print("Noray Network -> Client creation successful (joiner)")
		return OK

func connect_to_noray():
	err = await Noray.connect_to_host(HOST_ADDRESS, PORT)
	if err != OK:
		print("Noray Network -> Failed to connect to host: ", err)
		return err
	Noray.register_host()
	await Noray.on_pid
	active_oid = Noray.oid
	print("Noray Network -> OID assigned: ", active_oid)
	err = await Noray.register_remote()
	if err != OK:
		print("Noray Network -> Failed to register remote: ", err)
		return err
	print("Noray Network -> Registered remote with local_port: ", Noray.local_port)
	SIGNAL_connected_to_noray.emit(Noray.oid)
	return OK

func _process(delta: float) -> void:
	pass
