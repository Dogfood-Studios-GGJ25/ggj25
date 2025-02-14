extends SpotLight3D

var colliding = false

signal object_detected(object)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		check_all_raycasts()


func check_all_raycasts():
	var double_signal_protection = false
	for raycast in get_tree().get_nodes_in_group("Raycasts"):
		if raycast is RayCast3D:
			if raycast.is_colliding():
				double_signal_protection = true
				if !colliding:
					colliding = true
					var detected_object = raycast.get_collider()
					emit_signal("object_detected", detected_object)
					print(colliding)
					break
	if !double_signal_protection:
		colliding = false
		print(colliding)
