extends Node2D


func _ready() -> void:
	if Global.disableAllYandexServices: return
	
	YandexSDK.gameplay_started()
	
	get_viewport().focus_entered.connect(
		func(): YandexSDK.gameplay_started()
	)
	get_viewport().focus_exited.connect(
		func(): YandexSDK.gameplay_stopped()
	)
