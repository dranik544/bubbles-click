extends Node2D

@export var enableExplosion: bool = true
@export var bubblespawner: Node2D
@export var sprite: Sprite2D
@export var timer: Timer
@export var explosion: GPUParticles2D


func _ready() -> void:
	if Global.enableAnimation:
		explosion.emitting = true
	else:
		explosion.queue_free()
	sprite.rotation = rad_to_deg(randf_range(-180, 180))
	
	timer.timeout.connect(
		func():
			if Global.enableAnimation:
				var tween: Tween = create_tween()
				tween.tween_property(sprite, "modulate:a", 0.0, 5.0)
				await tween.finished
			else:
				await get_tree().create_timer(5.0).timeout
			
			queue_free()
	)
	
	if Global.enableAnimation:
		var tween: Tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_SPRING)
		tween.tween_property(sprite, "scale", Vector2(1.0, 1.0), 1.0)
