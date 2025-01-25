
extends Sprite3D
var turnSpeed = 0.003
var moveSpeed = 0.1
var angle = -PI
var time = 0
var swimming = false
var swimtime = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	swim(delta)
	
func swim(delta):
	turnSpeed = randf_range(-0.025, 0.025)

	if !swimming: 
		swimtime = randf_range(0.1,0.5) * 10
		swimming = true

	if swimming:
		time += delta
		if time <= swimtime:
			rotate_z(turnSpeed)
			translate_object_local(transform.basis.x * moveSpeed)
		else:
			time = 0
			swimming = false
