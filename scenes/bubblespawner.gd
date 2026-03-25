extends Node2D

@export var screensize: Vector2 = Vector2.ZERO
@export var spawntimer: Timer
@export var bubble1: PackedScene = preload("res://scenes/bubble.tscn")
@export var minTime: float = 0.5
@export var maxTime: float = 2.5
@export var chance: int = 99


func _ready() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	
	if screensize == Vector2.ZERO: screensize = get_viewport().size
	spawntimer.wait_time = randf_range(minTime, maxTime)
	spawntimer.timeout.connect(timeout)

func timeout():
	if bubble1 == null: return
	
	var newbubble = bubble1.instantiate()
	newbubble.global_position = Vector2(
		randf_range(128.0, screensize.x - 128.0),
		screensize.y + 128.0
	)
	var bubbletype = randi() % chance
	match bubbletype:
		1: newbubble.currentType = newbubble.type.rainbow
		_: newbubble.currentType = newbubble.type.default
	add_child(newbubble)
	
	spawntimer.wait_time = randf_range(minTime, maxTime)
