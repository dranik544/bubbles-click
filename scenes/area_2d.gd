extends Area2D

@export var collision: CollisionShape2D


func _ready() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	
	collision.shape.size = Vector2(
		get_viewport().size.x * 2,
		20
	)
	global_position.x = get_viewport().size.x / 2
	body_entered.connect(func(body: RigidBody2D): body.queue_free())
