extends Control

@export var timer: Timer


func _ready() -> void:
	if Global.disableAllYandexServices: return
	
	timer.timeout.connect(
		func():
			show()
			get_tree().paused = true
			get_tree().create_timer(3.0, true, false, true).timeout
			YandexSDK.show_interstitial_ad()
			get_tree().paused = false
			hide()
	)
