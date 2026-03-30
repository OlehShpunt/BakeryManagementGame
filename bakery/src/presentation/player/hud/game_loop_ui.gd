extends Control

@onready var phase_label = $CanvasLayer/Control/HBoxContainer/Left/PhaseLabel
@onready var round_num_label = $CanvasLayer/Control/HBoxContainer/Center/RoundNumberLabel
@onready var timer_label = $CanvasLayer/Control/HBoxContainer/Right/PhaseTimerLabel
@onready var phase_timer = $PhaseTimer
@onready var one_second_timer = $OneSecondTimer
@onready var balance_label = $CanvasLayer/Control/PlayerBalanceLabel


func _ready() -> void:
	# Enables PhaseTimerLabel second-based updates
	one_second_timer.timeout.connect(update_timer_label_each_second)
	#assign_new_timer(60)  # TEST
	balance_label.text = "Balance: $" + str(StateManager.get_player_state().balance) # TODO refactor into signal listener
	StateManager.get_player_state().player_balance_updated.connect(_on_player_balance_updated)


## Assigns the given phase name to the label
func change_phase(phase_name: String):
	if phase_name and phase_label:
		phase_label.text = phase_name


## Assigns the given round number to the label
func change_round(round_num: int):
	if round_num and round_num_label:
		round_num_label.text = str(round_num)


## Starts PhaseTimer with duration in seconds
func assign_new_timer(duration: int):
	if duration:
		phase_timer.start(duration)

		one_second_timer.stop()
		one_second_timer.start()


## Assigns the PhaseTimer time_left value to the label every second
## when OneSecondTimer emits a timeout signal
func update_timer_label_each_second():
	var curr_time = phase_timer.time_left as int
	if timer_label:
		timer_label.text = str(curr_time)


func _on_player_balance_updated(new_balance: int) -> void:
	balance_label.text = "Balance: $" + str(new_balance)
