extends Marker3D

@export var bubble_seen = preload("res://Environment/bubble.tscn")
		
func spawn_bubble() -> void:
	var bubble = bubble_seen.instantiate()
	var x = -4 + (randf() * 8.0)
	
	# Detach the bubble and reparent it to a different node
	bubble.global_transform = global_transform  # Preserve global position
	get_parent().get_parent().add_child(bubble)  # Reparent to the camera's parent or another node
	bubble.position.x += x

func _on_timer_timeout() -> void:
	spawn_bubble()
