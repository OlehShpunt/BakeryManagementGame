extends Control

@onready var join_name = $Panel/JoinName;
@onready var host_name = $Panel/HostName;
var STREET_LOCATION_PATH = "res://scenes/locations/street.tscn"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_join_button_pressed() -> void:
	var input_name = join_name.text.strip_edges()

	if input_name.is_empty():
		print("Network -> Enter a name before joining!")
		return

	# Set player info before joining
	network_setup.player_info["name"] = input_name

	# Join game (default to localhost for now)
	var err = network_setup.join_game()
	if err != OK:
		print("Network -> Failed to connect: ", err)
	else:
		print("Network -> Connecting to server as: ", input_name)


func _on_host_button_pressed() -> void:
	var input_name = host_name.text.strip_edges()

	if input_name.is_empty():
		print("Network -> Enter a name before hosting!")
		return

	# Set player info before hosting
	network_setup.player_info["name"] = input_name

	# Create the server
	var err = network_setup.create_game()
	if err != OK:
		print("Network -> Failed to host: ", err)
	else:
		print("Network -> Hosting server as: ", input_name)


func _on_load_game_button_pressed() -> void:
	if (!network_setup.players.is_empty()):
		network_setup.load_game.rpc(STREET_LOCATION_PATH)
	else: 
		print("Network -> cannot load the game, because player list is empty")
