extends Control

@export var timer: Timer


func _ready() -> void:
	if Global.disableAllYandexServices: return
	
	timer.timeout.connect(
		func():
			show()
			get_tree().paused = true
			
			await get_tree().create_timer(3.0).timeout
			
			await YandexFunc.show_interstitial_ad()
			
			if !Global.nowUpgradeSelect: get_tree().paused = false
			hide()
	)
