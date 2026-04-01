extends Node2D

@export var screensize: Vector2 = Vector2.ZERO
@export var spawntimer: Timer
@export var bubble1: PackedScene = preload("res://scenes/bubble.tscn")
@export var minTime: float = 3.0
@export var maxTime: float = 6.0
@export var spawnInPoint: bool = false

@export var wDefault: int = 100
@export var wRainbow: int = 30
@export var wGold: int = 15
@export var wSpace: int = 10
@export var wToxic: int = 20
@export var wCluster: int = 10
@export var wBomb: int = 20

var BubbleType = preload("res://scenes/bubble.gd").type

func _ready() -> void:
	await get_tree().process_frame
	if !spawnInPoint and screensize == Vector2.ZERO:
		screensize = get_viewport().size
	spawntimer.wait_time = randf_range(minTime, maxTime)
	spawntimer.timeout.connect(timeout)

func timeout() -> void:
	if not bubble1: return
	
	var pos: Vector2
	if !spawnInPoint:
		pos = Vector2(
			randf_range(128.0, screensize.x - 128.0),
			screensize.y + 128.0
		)
	else:
		pos = global_position + Vector2(randf_range(-25, 25), randf_range(-25, 25))
	
	
	var chosen = picktype()
	if chosen != "cluster":
		var bubble = bubble1.instantiate()
		bubble.global_position = pos
		bubble.currentType = getenum(chosen)
		get_tree().current_scene.add_child(bubble)
	else:
		for i in 8:
			var bubble = bubble1.instantiate()
			bubble.global_position = pos + Vector2(randf_range(-64, 64), randf_range(-64, 64))
			bubble.currentType = BubbleType.default
			get_tree().current_scene.add_child(bubble)
	
	spawntimer.wait_time = randf_range(
		minTime / Global.addChanceSpawnMultiplier,
		maxTime / Global.addChanceSpawnMultiplier
	)

func picktype() -> String:
	wToxic /= Global.chanceSpawnToxicBubble
	wGold *= Global.chanceSpawnRareBubbles
	wRainbow *= Global.chanceSpawnRareBubbles
	wSpace *= Global.chanceSpawnRareBubbles
	
	var total = wDefault + wRainbow + wGold + wSpace + wToxic + wCluster + wBomb
	var r = randi() % total
	
	var acc = wDefault
	
	if r < acc: return "default"
	
	acc += wRainbow
	if r < acc: return "rainbow"
	
	acc += wGold
	if r < acc: return "gold"
	
	acc += wSpace
	if r < acc: return "space"
	
	acc += wToxic
	if r < acc: return "toxic"
	
	acc += wCluster
	if r < acc: return "cluster"
	
	return "bomb"

func getenum(s: String):
	match s:
		"rainbow": return BubbleType.rainbow
		"gold": return BubbleType.gold
		"space": return BubbleType.space
		"toxic": return BubbleType.toxic
		"bomb": return BubbleType.bomb
		_: return BubbleType.default
