extends Node2D


func _ready() -> void:
	if Global.disableAllYandexServices: return
	
	YandexSDK.gameplay_started()
	
	get_viewport().focus_entered.connect(
		func():
			get_tree().paused = true
			YandexSDK.gameplay_started()
	)
	get_viewport().focus_exited.connect(
		func():
			get_tree().paused = false
			YandexSDK.gameplay_stopped()
	)
