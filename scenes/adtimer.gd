extends Timer


func _ready() -> void:
	if Global.disableAllYandexServices: return
	
	timeout.connect(
		func():
		YandexSDK.gameplay_stopped()
		YandexSDK.show_interstitial_ad()
		YandexSDK.gameplay_started()
		)
