extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var canMoveLeft : bool = true
var canMoveRight : bool = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if ((Input.is_action_pressed("ui_left") and canMoveLeft) or (Input.is_action_pressed("ui_right") and canMoveRight)):
		var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		canMoveLeft = true
		canMoveRight = true

		move_and_slide()

func _on_bouding_box_body_exited(body: Node3D) -> void:
	print_debug("Exited")
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction == Vector3.LEFT:
		# no more left for you.
		canMoveLeft = false
		canMoveRight = true
	else:
		canMoveRight = false
		canMoveLeft = true
