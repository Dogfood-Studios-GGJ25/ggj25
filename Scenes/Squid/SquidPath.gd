extends PathFollow3D

const SPEED := 37

func _physics_process(delta: float) -> void:
	progress += SPEED * delta
