extends CharacterBody3D

var time: float = 0
var float_speed: float = 1.5  # Slowed down for more water-like motion
var float_height: float = 0.3  # Reduced height for gentler bobbing
var facing_right: bool = true  # Track which direction we're facing
var target_rotation: float = 0  # Target rotation in radians
var rotation_speed: float = 5.0  # Speed of rotation transition

func _physics_process(delta):
	time += delta
	
	# Reset vertical velocity to prevent falling
	velocity.y = sin(time * float_speed) * float_height
	
	# Set target rotation based on input
	if Input.is_action_just_pressed("ui_left") and facing_right:
		target_rotation = PI  # Target 180 degrees to face left
		facing_right = false
	elif Input.is_action_just_pressed("ui_right") and not facing_right:
		target_rotation = 0  # Target 0 degrees to face right
		facing_right = true
	
	# Smoothly interpolate towards target rotation
	rotation.y = lerp_angle(rotation.y, target_rotation, rotation_speed * delta)
	
	# Required to update physics
	move_and_slide()


func _on_spot_light_3d_object_entered_light(object):
	if object == self:  # Only respond if we're the object that entered
		print("Entered light!")
		# Add your response code here


func _on_spot_light_3d_object_exited_light(object):
	if object == self:  # Only respond if we're the object that exited
		print("Exited light!")
		# Add your response code here
