class_name SellerGUI extends Control

@onready var inside_container = $PanelContainer/MarginContainer/InsideContainer
@onready var treadeable_component : TradeableComponent = $"../.."

func get_tradeable_component() -> TradeableComponent:
	return treadeable_component
