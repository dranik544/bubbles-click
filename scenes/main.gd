extends Node2D


func _ready() -> void:
	if !Global.disableAllYandexServices:
		if !YandexFunc.is_game_initialized:
			YandexFunc.init_game()
			for i in 5: await get_tree().process_frame
			YandexFunc.game_ready()
	
	if Global.disableAutoPause: return
	get_viewport().focus_entered.connect(
		func():
			get_tree().paused = true
	)
	get_viewport().focus_exited.connect(
		func():
			get_tree().paused = false
	)
