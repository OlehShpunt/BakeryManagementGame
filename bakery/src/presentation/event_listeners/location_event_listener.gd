class_name LocationEventListener
extends Node

@onready var _street_packed_scene: PackedScene = load(PathHolder.STREET_PATH)
@onready var _bakery_packed_scene: PackedScene = load(PathHolder.BAKERY_PATH)
@onready var _wholesale_shop_scene: PackedScene = load(PathHolder.WHOLESALE_SHOP_PATH)
@onready var _mini_market_scene: PackedScene = load(PathHolder.MINI_MARKET_PATH)
@onready var _kiosk_scene: PackedScene = load(PathHolder.KIOSK_PATH)
@onready var _supermarket_scene: PackedScene = load(PathHolder.SUPERMARKET_PATH)

var spawn_player_use_case: SpawnPlayerUseCase


func _init() -> void:
	spawn_player_use_case = SpawnPlayerUseCase.new()


func _ready() -> void:
	EventBus.load_location.connect(_on_load_location)

	print("[DEV][P] LocationEventListener initialized")


func _on_load_location(location: EnumHolder.Location):
	match location:
		EnumHolder.Location.Street:
			_load_scene(_street_packed_scene)
		EnumHolder.Location.Bakery1:
			_load_scene(_bakery_packed_scene)
		EnumHolder.Location.WholesaleShop:
			_load_scene(_wholesale_shop_scene)
		EnumHolder.Location.Kiosk:
			_load_scene(_kiosk_scene)
		EnumHolder.Location.MiniMarket:
			_load_scene(_mini_market_scene)
		EnumHolder.Location.Supermarket:
			_load_scene(_supermarket_scene)

	var current_player_location: EnumHolder.Location = StateManager.get_player_state().get_player_location()
	var coordinates = PlayerSpawnCoordinatesResolver.resolve(current_player_location, location)
	spawn_player_use_case.execute(location, coordinates)


func _load_scene(packed_scene: PackedScene):
	var tree = get_tree()
	var current_scene = tree.current_scene

	if (current_scene):
		current_scene.queue_free()

	tree.root.remove_child(tree.current_scene)
	tree.current_scene = null

	var scene_instance = packed_scene.instantiate()
	tree.root.add_child(scene_instance)
	tree.current_scene = scene_instance

	print("[DEV][P] Responded to \"EventBus.load_location\" - street scene successfully loaded")
