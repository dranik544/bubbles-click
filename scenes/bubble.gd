extends RigidBody2D

enum type {default, rainbow}
@export var currentType: type
@export var enableAnimation: bool = true
@export var sprite: Sprite2D
@export var shadow: Sprite2D
@export var button: Button
@export var audio: AudioStreamPlayer2D
@export var rainbowAudio: AudioStreamPlayer2D
@export var light: PointLight2D
@export var rainbow: GPUParticles2D
@export var minSpeed: float = -0.05
@export var maxSpeed: float = -0.4
@export var addscore: int = 1
var nowBubbleDestroying: bool = false
var spriteDefaultScale: Vector2 = Vector2.ZERO
var time: float = 0.0


func _ready() -> void:
	spriteDefaultScale = sprite.scale
	button.pressed.connect(buttonpressed)
	gravity_scale = randf_range(minSpeed, maxSpeed)
	scale += Vector2(-0.3, 0.3)
	
	match currentType:
		type.default:
			pass
		type.rainbow:
			if Global.enableAnimation:
				rainbow.visible = true
				rainbow.emitting = true
			sprite.texture = load("res://sprites/default/bubble2.png")
			shadow.texture = load("res://sprites/default/bubble2.png")
			rainbowAudio.play()
			addscore = 25

func _process(delta: float) -> void:
	if Global.enableAnimation and !nowBubbleDestroying:
		time += delta
		sprite.scale = spriteDefaultScale + Vector2(
			sin(time * 2) * 0.06,
			sin(time) * 0.06
		)
		shadow.scale = spriteDefaultScale + Vector2(
			sin(time * 2) * 0.06,
			sin(time) * 0.06
		)
		sprite.skew = 0.0 + sin(time * 2) * 0.02
		shadow.skew = 0.0 + sin(time * 2) * 0.02

func buttonpressed():
	destroy()

func destroy():
	if nowBubbleDestroying: return
	
	Global.score += addscore
	Global.updatescore.emit()
	
	if Global.enableAnimation:
		nowBubbleDestroying = true
		
		var tween: Tween = create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_BACK)
		tween.tween_property(sprite, "scale", Vector2.ZERO, 0.15)
		tween.tween_property(shadow, "scale", Vector2.ZERO, 0.15)
		tween.tween_property(light, "color:a", 0, 0.005)
		
		audio.play()
		
		await tween.finished
		sprite.visible = false
		shadow.visible = false
		
		$GPUParticles2D.restart()
		if get_tree(): await get_tree().create_timer(0.3).timeout
	else:
		nowBubbleDestroying = true
		
		audio.play()
		sprite.visible = false
		shadow.visible = false
		if get_tree(): await get_tree().create_timer(0.3).timeout
	
	queue_free()
