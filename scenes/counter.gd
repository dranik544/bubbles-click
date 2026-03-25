extends Label


func _ready() -> void:
	Global.updatescore.connect(updatecounter)
	updatecounter()

func updatecounter():
	text = str(Global.score)
	
	if Global.enableAnimation:
		var tween: Tween = create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_EXPO)
		tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.25)
		
		await tween.finished
		
		tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(self, "scale", Vector2(1.0, 1.0), 1.1)
