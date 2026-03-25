extends Timer


func _ready() -> void:
	timeout.connect(
		func():
		YandexSDK.gameplay_stopped()
		YandexSDK.show_interstitial_ad()
		YandexSDK.gameplay_started()
		)
