extends Node2D


func _ready() -> void:
	if !Global.disableAllYandexServices:
		YandexSDK.gameplay_started()
	
	if Global.disableAutoPause: return
	get_viewport().focus_entered.connect(
		func():
			get_tree().paused = true
			if !Global.disableAllYandexServices:
				YandexSDK.gameplay_started()
	)
	get_viewport().focus_exited.connect(
		func():
			get_tree().paused = false
			if !Global.disableAllYandexServices:
				YandexSDK.gameplay_stopped()
	)
