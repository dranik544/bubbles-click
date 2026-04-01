extends Label


func showscore(score: int, colortext: Color = Color.WHITE):
	reparent(get_tree().current_scene)
	
	text = str(score)
	modulate = colortext
	pivot_offset = size / 2
	
	visible = true
	
	if Global.enableAnimation:
		scale = Vector2(0.0, 0.0)
		
		var tween: Tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(self, "scale", Vector2(1.0, 1.0), 1.5)
		
		await tween.finished
		
		tween = create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_EXPO)
		tween.tween_property(self, "modulate:a", 0.0, 2.0)
		
		await tween.finished
	else:
		await get_tree().create_timer(3.5).timeout
	
	queue_free()
