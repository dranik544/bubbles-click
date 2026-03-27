extends Timer


func _ready() -> void:
	if Global.disableAllYandexServices: return
	
	timeout.connect(func():YandexSDK.show_interstitial_ad())
