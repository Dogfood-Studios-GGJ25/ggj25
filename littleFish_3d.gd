
extends Sprite3D
var speed = 0.003
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

	if !swimming: 
		swimtime = randf_range(0.1,0.5) * 10
		#rotation += randf() * PI
		#rotate_z(speed)
		swimming = true

	if swimming:
		time += delta
		if time <= swimtime:
			#var velocity = Vector3.LEFT.rotated(rotation) * speed
			rotate_z(speed)
			#transform.basis.x *= speed
			#position += velocity
		else:
			time = 0
			swimming = false
