extends Node

signal noray_connected(oid)

const NORAY_ADDRESS = "tomfol.io"
const NORAY_PORT = 8890

var is_host = false
var external_oid = ""

func _ready():
	print("[Instance ", get_instance_id(), "] Starting Noray setup")
	Noray.on_connect_to_host.connect(on_noray_connected)
	Noray.on_connect_nat.connect(handle_nat_connection)
	Noray.on_connect_relay.connect(handle_relay_connection)

func on_noray_connected():
	print("[", "Host" if is_host else "Joiner", "] Connected to Noray server")
	Noray.register_host()
	await Noray.on_pid
	await Noray.register_remote()
	print("[", "Host" if is_host else "Joiner", "] Registered with local_port: ", Noray.local_port)
	noray_connected.emit(Noray.oid)

func host():
	print("[Host] Hosting on Instance ", get_instance_id())
	if not is_host:
		Noray.connect_to_host(NORAY_ADDRESS, NORAY_PORT)
		await noray_connected
	var peer = ENetMultiplayerPeer.new()
	var err = peer.create_server(Noray.local_port)
	if err != OK:
		print("[Host] Failed to create server: ", err)
		return
	multiplayer.multiplayer_peer = peer
	is_host = true
	print("[Host] Hosting successful on port ", Noray.local_port, " with OID ", Noray.oid)

func join(oid):
	print("[Joiner] Joining with OID ", oid, " on Instance ", get_instance_id())
	if is_host:
		print("[Joiner] Cannot join: Already hosting")
		return
	if oid == Noray.oid and Noray.oid != "":
		print("[Joiner] Error: Cannot join your own OID (", Noray.oid, ")")
		return
	if Noray.local_port == 0:
		Noray.connect_to_host(NORAY_ADDRESS, NORAY_PORT)
		await noray_connected
	external_oid = oid
	print("[Joiner] Calling connect_nat with OID ", oid)
	Noray.connect_nat(oid)
	print("[Joiner] connect_nat called, awaiting NAT connection...")

func handle_nat_connection(address, port):
	print("[Joiner] Handling NAT connection to ", address, ":", port)
	var err = await connect_to_server(address, port)
	if err != OK && !is_host:
		print("[Joiner] NAT failed, using relay")
		Noray.connect_relay(external_oid)
		err = OK
	return err

func handle_relay_connection(address, port):
	print("[Joiner] Handling relay connection to ", address, ":", port)
	return await connect_to_server(address, port)

func connect_to_server(address, port):
	var err = OK
	print("[", "Host" if is_host else "Joiner", "] Connecting to server at ", address, ":", port)
	if !is_host:
		var udp = PacketPeerUDP.new()
		err = udp.bind(Noray.local_port)
		if err != OK:
			print("[Joiner] Failed to bind UDP to local_port ", Noray.local_port, ": ", err)
			udp.close()
			return err
		udp.set_dest_address(address, port)
		err = await PacketHandshake.over_packet_peer(udp)
		if err != OK:
			print("[Joiner] Handshake failed with error: ", err)
			udp.close()
			return err
		print("[Joiner] Handshake success")
		udp.close()
		var peer = ENetMultiplayerPeer.new()
		err = peer.create_client(address, port, 0, 0, 0, Noray.local_port)
		if err != OK:
			print("[Joiner] Failed to create client: ", err)
			return err
		multiplayer.multiplayer_peer = peer
		print("[Joiner] Client connected successfully")
		return OK
	else:
		err = await PacketHandshake.over_enet(multiplayer.multiplayer_peer.host, address, port)
		if err != OK:
			print("[Host] Handshake failed: ", err)
			return err
		print("[Host] Handshake success")
		return OK
