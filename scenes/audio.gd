extends AudioStreamPlayer2D


func _ready() -> void:
	Global.updatesound.connect(
		func():
			volume_db = 0.0 if Global.enableSound else -80.0
	)
