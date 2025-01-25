extends RigidBody3D

class_name Bubble

@export var float_speed: float = 1.0  # Base upward speed
@export var wobble_strength: float = 0.2  # How much side-to-side movement
@export var wobble_speed: float = 2.0  # How fast it wobbles
@export var oxygen_value: int = 3 # How much oxygen does this bubble give back?

var time: float = 0.0
var initial_position: Vector3

func _ready():
	initial_position = position

func _process(delta):
	time += delta
	
	# Calculate upward movement
	var upward = Vector3.UP * float_speed * delta
	
	# Add some gentle sideways wobble using sine waves
	var wobble = Vector3(
		sin(time * wobble_speed) * wobble_strength,
		0,
		cos(time * wobble_speed * 0.7) * wobble_strength  # Different frequency for z-axis
	)
	
	# Combine movements and update position
	position += upward + (wobble * delta)

func pop_for_oxygen() -> int:
	queue_free()
	# TODO: Do an elaborate POP action!
	return oxygen_value
	
