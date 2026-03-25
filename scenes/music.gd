extends AudioStreamPlayer


func _ready() -> void:
	Global.updatemusic.connect(
		func():
			volume_db = 0.0 if Global.enableMusic else -80.0
	)
