extends GPUParticles2D


func _ready() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	
	if !Global.enableAnimation: queue_free()
	
	global_position.y = get_viewport().size.y / 2
	process_material.emission_box_extents.y = get_viewport().size.y
	restart()
