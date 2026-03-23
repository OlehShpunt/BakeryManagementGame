extends Control

@onready var player_name_text_edit: TextEdit = $PlayerNameTextEdit

var start_game_use_case: StartGameUseCase
var change_player_name_use_case: ChangePlayerNameUseCase


func _init() -> void:
	start_game_use_case = StartGameUseCase.new()
	change_player_name_use_case = ChangePlayerNameUseCase.new()


func _on_start_game_button_pressed() -> void:
	print("[DEV][P] Start game button pressed")

	var player_name = player_name_text_edit.text

	if (player_name.is_empty()):
		return

	change_player_name_use_case.execute(player_name)
	start_game_use_case.execute()
	self.hide()
