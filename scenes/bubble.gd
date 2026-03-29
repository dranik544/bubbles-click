extends RigidBody2D

enum type {default, rainbow, gold, space, toxic, bomb}
@export var currentType: type

@export_category("Default")
@export var collision: CollisionShape2D
@export var sprite: Sprite2D
@export var shadow: Sprite2D
@export var light: Sprite2D
@export var button: Button
@export var audio: AudioStreamPlayer2D
@export var addscore: int = 1
@export var minSpeed: float = -0.05
@export var maxSpeed: float = -0.45

@export_category("Rainbow type")
@export var rainbowParticles: GPUParticles2D
@export_category("Gold type")
@export var goldParticles: GPUParticles2D
@export_category("Space type")
@export var spaceParticles: GPUParticles2D
@export_category("Toxic type")
@export var toxicParticles: GPUParticles2D
@export var toxicParticles2: GPUParticles2D
@export_category("Bomb type")
@export var bombParticles: GPUParticles2D

var nowBubbleDestroying: bool = false


func _ready() -> void:
	button.pressed.connect(buttonpressed)
	gravity_scale = randf_range(minSpeed, maxSpeed)
	
	var randomscale: float = randf_range(-0.1, 0.2)
	sprite.scale += Vector2(randomscale, randomscale)
	shadow.scale += Vector2(randomscale, randomscale)
	light.scale += Vector2(randomscale, randomscale)
	button.scale += Vector2(randomscale, randomscale)
	collision.scale += Vector2(randomscale, randomscale)
	
	if !Global.enableAnimation: light.queue_free()
	
	match currentType:
		type.default:
			sprite.texture = load("res://sprites/default/bubble1.png")
			shadow.texture = load("res://sprites/default/bubble1.png")
		type.rainbow:
			if Global.enableAnimation:
				rainbowParticles.visible = true
				rainbowParticles.emitting = true
			else:
				rainbowParticles.queue_free()
			sprite.texture = load("res://sprites/default/bubble2.png")
			shadow.texture = load("res://sprites/default/bubble2.png")
			addscore = 15
		type.gold:
			if Global.enableAnimation:
				goldParticles.visible = true
				goldParticles.emitting = true
			else:
				goldParticles.queue_free()
			sprite.texture = load("res://sprites/default/bubble3.png")
			shadow.texture = load("res://sprites/default/bubble3.png")
			addscore = 30
		type.space:
			if Global.enableAnimation:
				spaceParticles.visible = true
				spaceParticles.emitting = true
			else:
				spaceParticles.queue_free()
			sprite.texture = load("res://sprites/default/bubble4.png")
			shadow.texture = load("res://sprites/default/bubble4.png")
			addscore = 65
		type.toxic:
			if Global.enableAnimation:
				toxicParticles.visible = true
				toxicParticles.emitting = true
				toxicParticles2.visible = true
				toxicParticles2.emitting = true
			else:
				toxicParticles.queue_free()
				toxicParticles2.queue_free()
			sprite.texture = load("res://sprites/default/bubble5.png")
			shadow.texture = load("res://sprites/default/bubble5.png")
			addscore = -25
		type.bomb:
			if Global.enableAnimation:
				bombParticles.visible = true
				bombParticles.emitting = true
			else:
				bombParticles.queue_free()
			sprite.texture = load("res://sprites/default/bubble6.png")
			shadow.texture = load("res://sprites/default/bubble6.png")
			addscore = -5

func buttonpressed():
	destroy()

func destroy():
	if nowBubbleDestroying: return
	
	Global.addscore(addscore)
	
	if get_node("addedscore") != null:
		match currentType:
			type.default: get_node("addedscore").showscore(addscore * Global.addScoreMultiplier, Color.WHITE)
			type.rainbow: get_node("addedscore").showscore(addscore * Global.addScoreMultiplier, Color.HOT_PINK)
			type.gold: get_node("addedscore").showscore(addscore * Global.addScoreMultiplier, Color.GOLD)
			type.space: get_node("addedscore").showscore(addscore * Global.addScoreMultiplier, Color.REBECCA_PURPLE)
			type.toxic: get_node("addedscore").showscore(addscore * Global.addScoreMultiplier, Color.DARK_GREEN)
	
	if currentType == type.bomb: bombdestroy()
	
	if Global.enableAnimation:
		nowBubbleDestroying = true
		
		var tween: Tween = create_tween()
		var othertween: Tween = create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_BACK)
		tween.tween_property(sprite, "scale", Vector2.ZERO, 0.25)
		othertween.tween_property(shadow, "scale", Vector2.ZERO, 0.2)
		othertween.tween_property(light, "modulate:a", 0.0, 0.25)
		
		audio.play()
		
		await tween.finished
		
		sprite.visible = false
		shadow.visible = false
		light.visible = false
		
		$GPUParticles2D.restart()
		if get_tree(): await get_tree().create_timer(0.3).timeout
	else:
		nowBubbleDestroying = true
		
		audio.play()
		sprite.visible = false
		shadow.visible = false
		light.visible = false
		
		if get_tree(): await get_tree().create_timer(0.3).timeout
	
	queue_free()

func bombdestroy():
	var hole: Node2D = load("res://scenes/hole.tscn").instantiate()
	hole.global_position = global_position
	get_tree().current_scene.add_child(hole)
