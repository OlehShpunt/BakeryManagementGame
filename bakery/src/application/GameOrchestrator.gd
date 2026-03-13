## This class orchestrates the game flow by utilizing GameController class

extends Node


const PRE_GAME_PHASE = "Get Ready to Play!"
const BUYING_PHASE = "Buying Phase"
const PREPARATION_PHASE = "Preparation Phase"
const SELLING_PHASE = "Selling Phase"
const MAX_NUM_ROUNDS = 5

var current_phase = PRE_GAME_PHASE


var current_round_num = 1


var phase_duration_handler = PhaseDurationHandler.new()


var phase_timer: Timer = Timer.new()


class PhaseDurationHandler:
	var buying: int = 5#240       # 4 min
	var preparation: int = 5#420  # 7 min
	var selling: int = 5#300      # 5 min
	var pre_game: int = 5      # 10 sec


func start_game_processes():
	set_up_timer()
	GameLoopUi.change_phase(current_phase)
	GameLoopUi.change_round(current_round_num)


func set_up_timer():
	print("Camel > setting up timer")
	phase_timer.timeout.connect(toggle_phase)
	phase_timer.autostart = false
	phase_timer.one_shot = true
	phase_timer.wait_time = phase_duration_handler.pre_game
	print("Camel > starting timer with waittime ", phase_timer.wait_time)
	add_child(phase_timer)
	phase_timer.start()
	#GameLoopUi.assign_new_timer(phase_duration_handler.pre_game)


func toggle_phase():
	print("Camel > toggling phase with current phase being ", current_phase)
	if current_phase == BUYING_PHASE:
		print("Camel > buying phase now 1 -> preparation phase")
		current_phase = PREPARATION_PHASE
		GameController.triggerPreparationPhase(phase_duration_handler.preparation, current_round_num)
		phase_timer.start(phase_duration_handler.preparation)
	elif current_phase == PREPARATION_PHASE:
		print("Camel > preparation phase now 2 -> selling phase")
		current_phase = SELLING_PHASE
		GameController.triggerSellingPhase(phase_duration_handler.selling, current_round_num)
		phase_timer.start(phase_duration_handler.selling)
	elif current_phase == SELLING_PHASE:
		
		current_round_num = current_round_num + 1
		if current_round_num <= MAX_NUM_ROUNDS:
			GameLoopUi.change_round(current_round_num)
		else:
			GameLoopUi.change_phase("GAME IS FINISHED")
			# TODO game end logic
			return
		
		print("Camel > selling phase now 3 -> buying phase")
		current_phase = BUYING_PHASE
		GameController.triggerBuyingPhase(phase_duration_handler.buying)
		phase_timer.start(phase_duration_handler.buying)
	else:  # i.g. pre game phase
		print("Camel > ELSE phase now 4 -> buying phase")
		current_phase = BUYING_PHASE
		GameController.triggerBuyingPhase(phase_duration_handler.buying)
		phase_timer.start(phase_duration_handler.buying)
		# TODO start GameController's next round method
	
	
