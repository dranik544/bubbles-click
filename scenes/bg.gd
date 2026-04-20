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
	
	get_viewport().size_changed.connect(
		func():
			size = get_viewport().size
	)
