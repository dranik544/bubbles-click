extends Node2D

@export var screensize: Vector2 = Vector2.ZERO
@export var spawntimer: Timer
@export var bubble1: PackedScene = preload("res://scenes/bubble.tscn")
@export var minTime: float = 1.0
@export var maxTime: float = 3.0
@export var chance: int = 100


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
	
	var newbubble: RigidBody2D = bubble1.instantiate()
	newbubble.global_position = Vector2(
		randf_range(128.0, screensize.x - 128.0),
		screensize.y + 128.0
	)
	var bubbletype = randi() % chance
	match bubbletype:
		1,2,3,4,5,6,7,8,9,10: newbubble.currentType = newbubble.type.rainbow
		
		11,12,13,14,15: newbubble.currentType = newbubble.type.gold
		
		16,17,18,19,20: newbubble.currentType = newbubble.type.space
		
		21,22,23,24,25,26,27,28,29,30: newbubble.currentType = newbubble.type.toxic
		
		31,32,33,34,35,36,37:
			for i in range(8):
				var morebubble = bubble1.instantiate()
				var offset = Vector2(randf_range(-64, 64), randf_range(-64, 64))
				morebubble.global_position = newbubble.global_position + offset
				morebubble.currentType = morebubble.type.default
				add_child(morebubble)
			return
		
		_: newbubble.currentType = newbubble.type.default
	
	add_child(newbubble)
	
	spawntimer.wait_time = randf_range(minTime, maxTime)
