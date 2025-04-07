extends Control

@onready var join_name = $Panel/JoinName
@onready var host_name = $Panel/HostName
@onready var OID : TextEdit = $Panel/OID
@onready var MY_OID : Label = $Panel/MY_OID
var STREET_LOCATION_PATH = "res://scenes/locations/street.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#network_setup.noray_connected.connect(_on_SIGNAL_connected_to_noray)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_SIGNAL_connected_to_noray(oid):
	print("Start Menu -> OID for joining: ", oid)
	MY_OID.text = oid
	


func _on_join_button_pressed() -> void:
	var input_name = join_name.text.strip_edges()

	if input_name.is_empty():
		print("Network -> Enter a name before joining!")
		return
	var id = await OID.text
	
	if id == "":
		print("Start Menu -> OID must be specified")
	#else:
		#network_setup.join(OID.text)


func _on_host_button_pressed() -> void:
	var input_name = host_name.text.strip_edges()

	if input_name.is_empty():
		print("Network -> Enter a name before hosting!")
		return
	
	#network_setup.host()


func _on_load_game_button_pressed() -> void:
	pass
	#if (!network_setup.players.is_empty()):
		#network_setup.load_game.rpc(STREET_LOCATION_PATH)
	#else: 
		#print("Network -> cannot load the game, because player list is empty")
