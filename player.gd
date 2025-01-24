extends CharacterBody3D


const SPEED = 1.0
const MAX_SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ACCELERATION_TIME = 1.0 
const IDLE_GRAVITY = 0.5

var current_speed_x: float = 0.0
var current_speed_y: float = 0.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta


	var input_dir := Input.get_vector("player_left", "player_right","player_up", "player_down")
	var direction := (transform.basis * Vector3(input_dir.x, input_dir.y, 0)).normalized()
	
	
	if abs(direction.x) > 0:
		current_speed_x = move_toward(current_speed_x, MAX_SPEED * sign(direction.x), 
			(MAX_SPEED / ACCELERATION_TIME) * delta)
	else:
		current_speed_x = move_toward(current_speed_x, 0, (MAX_SPEED / ACCELERATION_TIME) * delta)
	
	if abs(direction.y) > 0:
		current_speed_y = move_toward(current_speed_y, MAX_SPEED * sign(-direction.y), 
			(MAX_SPEED / ACCELERATION_TIME) * delta)
	else:
		current_speed_y = move_toward(current_speed_y, 0, (MAX_SPEED / ACCELERATION_TIME) * delta)
		current_speed_y -= IDLE_GRAVITY * delta
	
	velocity.x = current_speed_x
	velocity.y = current_speed_y

	move_and_slide()
