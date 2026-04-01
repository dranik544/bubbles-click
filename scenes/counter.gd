extends Label

var tween: Tween


func _ready() -> void:
	pivot_offset = size / 2
	Global.updatescore.connect(updatecounter)
	updatecounter()

func updatecounter():
	text = str(Global.score)
	
	if Global.enableAnimation:
		if tween != null: tween.kill()
		tween = create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_EXPO)
		tween.tween_property(self, "scale", Vector2(1.8, 1.8), 0.25)
		
		await tween.finished
		
		tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(self, "scale", Vector2(1.0, 1.0), 1.1)
		
		await tween.finished
		
		tween.kill()
		tween = null
