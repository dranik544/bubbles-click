extends Control

@export var label: Label
@export var bg: ColorRect
@export var vbox: VBoxContainer


func _ready() -> void:
	if label: label.pivot_offset = label.size / 2
	get_viewport().size_changed.connect(
		func():
			if label: label.pivot_offset = label.size / 2
	)
	
	
	Global.updatelevel.connect(
		func():
			if !Global.enableAnimation:
				label.visible = true
				vbox.visible = false
				get_tree().paused = true
				
				show()
				
				await get_tree().create_timer(2.6, true, false, true).timeout
				label.visible = false
				vbox.visible = true
			else:
				label.visible = true
				vbox.visible = false
				label.scale = Vector2.ZERO
				bg.modulate.a = 0.0
				get_tree().paused = true
				
				show()
				
				var tween: Tween = create_tween()
				tween.set_ignore_time_scale(true)
				tween.tween_property(bg, "modulate:a", 1.0, 0.4)
				tween.set_ease(Tween.EASE_OUT)
				tween.set_trans(Tween.TRANS_ELASTIC)
				tween.tween_property(label, "scale", Vector2(1.0, 1.0), 1.2)
				
				await tween.finished
				await get_tree().create_timer(1.0, true, false, true).timeout
				
				label.visible = false
				vbox.visible = true
	)
