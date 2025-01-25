extends Marker3D

@export var nr_of_bubbles : int = 3
@export var spawn_interval : int = 3

var bubble_seen = preload("res://Environment/bubble.tscn")
		
func spawn_bubble() -> void:
	var bubble = bubble_seen.instantiate()
	var x = -5 + (randf() * 10.0)
	bubble.position = Vector3(x, position.y, position.z)	
	add_child(bubble)

func _on_timer_timeout() -> void:
	spawn_bubble()
