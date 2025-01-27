extends Marker3D

@export var bubble_seen = preload("res://Environment/bubble.tscn")
		
func spawn_bubble() -> void:
	var bubble = bubble_seen.instantiate()
	var x = -4 + (randf() * 8.0)
	#bubble.position = Vector3(x, position.y, position.z)	
	#add_child(bubble)
	
	# Detach the bubble and reparent it to a different node
	bubble.global_transform = global_transform  # Preserve global position
	get_parent().get_parent().add_child(bubble)  # Reparent to the camera's parent or another node
	#remove_child(bubble)  # Detach from the current parent
	bubble.position.x += x

func _on_timer_timeout() -> void:
	spawn_bubble()
