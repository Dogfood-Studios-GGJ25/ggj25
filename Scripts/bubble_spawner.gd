extends Marker3D

@export var bubble_seen = preload("res://Environment/bubble.tscn")
		
func spawn_bubble() -> void:
	var bubble = bubble_seen.instantiate()
	var x = -5 + (randf() * 10.0)
	bubble.position = Vector3(x, global_position.y, global_position.z)	
	get_parent_node_3d().get_parent_node_3d().add_child(bubble)

func _on_timer_timeout() -> void:
	spawn_bubble()
