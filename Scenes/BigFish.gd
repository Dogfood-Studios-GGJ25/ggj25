extends Sprite2D
var speed = 0.3
var angle = -PI
var time = 0
var swimming = false
var swimtime = 0.0
var variance = 0.003
var targetRotation = 0.00
var targetRotationDirection = 0
var rotationSpeed = 0.0001
var rotating = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	swim(delta)
	rotateSlow()
	
func swim(delta):
	if !swimming: 
		swimtime = randf_range(0.1,0.5) * 10
		swimming = true

	if swimming:
		time += delta
		if time <= swimtime:
			var velocity = Vector2.LEFT.rotated(rotation) * speed
			position += velocity
		else:
			time = 0
			swimming = false

func rotateSlow():
	if !rotating:
		targetRotation = rotation + randf() * PI #* variance #setting amount of rotation
		#print_debug("targetrotation: ", targetRotation)
		rotating = true 
		var targetrotationseed = randf()
		if targetrotationseed <0.5:
			targetRotationDirection = -1
		else:
			targetRotationDirection = 1
		targetRotation *= targetRotationDirection #amount of rotation negated dependent on direction
	else:
		
		if targetRotationDirection == 1:
			if targetRotation > 0.000: #as long targetrotation is higher than zero
				print_debug("Before: ",targetRotation)
				targetRotation -= rotationSpeed #rotationspeed subtracted for check
				print_debug("After: ",targetRotation)
				rotation -= rotationSpeed #actual rotation
			else:
				rotating = false
				targetRotationDirection = 0
			
		elif targetRotationDirection == -1:
			print(targetRotation)
			if targetRotation < 0.000: #as long targetrotation is lower than zero
				targetRotation += rotationSpeed #rotationspeed added for check
				rotation += rotationSpeed #actual rotation
			else:
				rotating = false
				targetRotationDirection = 0
	
