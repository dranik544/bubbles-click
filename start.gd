extends Node2D

func _ready() -> void:
	if Global.disableAllYandexServices: return
	
	YandexSDK.init_game()
	YandexSDK.game_ready()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	elif event is InputEventScreenTouch and event.pressed:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
