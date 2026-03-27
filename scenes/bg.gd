extends TextureRect


func _ready() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	
	size = get_viewport().size
	position = Vector2.ZERO
	
	texture = load("res://sprites/default/bg1.png")
