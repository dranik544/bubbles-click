extends RigidBody2D

enum type {default, rainbow, gold, space, toxic}
@export var currentType: type

@export_category("Default")
@export var sprite: Sprite2D
@export var shadow: Sprite2D
@export var button: Button
@export var audio: AudioStreamPlayer2D
@export var light: PointLight2D
@export var addscore: int = 1
@export var minSpeed: float = -0.05
@export var maxSpeed: float = -0.4

@export_category("Rainbow type")
@export var rainbowAudio: AudioStreamPlayer2D
@export var rainbowParticles: GPUParticles2D
@export_category("Gold type")
@export var goldAudio: AudioStreamPlayer2D
@export var goldParticles: GPUParticles2D
@export_category("Space type")
@export var spaceAudio: AudioStreamPlayer2D
@export var spaceParticles: GPUParticles2D
@export_category("Toxic type")
@export var toxicAudio: AudioStreamPlayer2D
@export var toxicParticles: GPUParticles2D
@export var toxicParticles2: GPUParticles2D
@export var toxicLight: PointLight2D

var nowBubbleDestroying: bool = false
var spriteDefaultScale: Vector2 = Vector2.ZERO
var time: float = 0.0


func _ready() -> void:
	button.pressed.connect(buttonpressed)
	gravity_scale = randf_range(minSpeed, maxSpeed)
	spriteDefaultScale = sprite.scale
	
	match currentType:
		type.default:
			pass
		type.rainbow:
			if Global.enableAnimation:
				rainbowParticles.visible = true
				rainbowParticles.emitting = true
			sprite.texture = load("res://sprites/default/bubble2.png")
			shadow.texture = load("res://sprites/default/bubble2.png")
			rainbowAudio.play()
			addscore = 10
		type.gold:
			if Global.enableAnimation:
				goldParticles.visible = true
				goldParticles.emitting = true
			sprite.texture = load("res://sprites/default/bubble3.png")
			shadow.texture = load("res://sprites/default/bubble3.png")
			goldAudio.play()
			addscore = 50
		type.space:
			if Global.enableAnimation:
				spaceParticles.visible = true
				spaceParticles.emitting = true
			sprite.texture = load("res://sprites/default/bubble4.png")
			shadow.texture = load("res://sprites/default/bubble4.png")
			spaceAudio.play()
			addscore = 100
		type.toxic:
			if Global.enableAnimation:
				toxicParticles.visible = true
				toxicParticles.emitting = true
				toxicParticles2.visible = true
				toxicParticles2.emitting = true
			toxicLight.visible = true
			sprite.texture = load("res://sprites/default/bubble5.png")
			shadow.texture = load("res://sprites/default/bubble5.png")
			toxicAudio.play()
			addscore = -25

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
		#sprite.skew = 0.0 + sin(time * 2) * 0.02
		#shadow.skew = 0.0 + sin(time * 2) * 0.02

func buttonpressed():
	destroy()

func destroy():
	if nowBubbleDestroying: return
	
	Global.score += addscore
	Global.updatescore.emit()
	if get_node("addedscore") != null:
		match currentType:
			type.default: get_node("addedscore").showscore(addscore, Color.WHITE)
			type.rainbow: get_node("addedscore").showscore(addscore, Color.HOT_PINK)
			type.gold: get_node("addedscore").showscore(addscore, Color.GOLD)
			type.space: get_node("addedscore").showscore(addscore, Color.REBECCA_PURPLE)
			type.toxic: get_node("addedscore").showscore(addscore, Color.DARK_GREEN)
	
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
