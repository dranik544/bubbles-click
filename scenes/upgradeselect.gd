extends Control


func _ready() -> void:
	Global.updatelevel.connect(func():
		await get_tree().create_timer(0.8, true, false, true).timeout
		get_tree().paused = true
		show()
	)
