extends CharacterBody3D

@onready var spring_arm = $SpringArm3D
@onready var spotlight = $SpringArm3D/SpotLight3D

const SPEED = 1.0
const MAX_SPEED = 3.0
const ACCELERATION_TIME = 0.8
const IDLE_GRAVITY = 0.1
const TERMINAL_VELOCITY = -0.5

var current_speed_x: float = 0.0
var current_speed_y: float = 0.0
var gravity_velocity: float = 0.0 
var camera

var spotlight_state: bool = false


func _ready():
	camera = get_tree().get_first_node_in_group("Camera3D")
	


func _physics_process(delta: float) -> void:
# Spotlight looking at mouse position
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	var t = -ray_origin.z / ray_direction.z 
	var world_pos = ray_origin + ray_direction * t
	spring_arm.look_at(world_pos)

# actions
	if Input.is_action_just_pressed("mouse_left_click"):
		if spotlight.visible:
			spotlight_state = false
			spotlight.visible = false
		else:
			spotlight_state = true
			spotlight.visible = true
	
# directional input
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
		gravity_velocity = 0 
	else:
		current_speed_y = move_toward(current_speed_y, 0, (MAX_SPEED / ACCELERATION_TIME) * delta)
		gravity_velocity = move_toward(gravity_velocity, TERMINAL_VELOCITY, IDLE_GRAVITY * delta)

	velocity.x = current_speed_x
	velocity.y = current_speed_y + gravity_velocity

	move_and_slide()


func on_interact(state):
	match state:
		"quick_time":
			print("QUICK TIME START")
		"Jumpscare":
			print("JUMPSCARE START")


func _on_spot_light_3d_object_entered_light(object):
	if object == self:  # Only respond if we're the object that entered
		print("Entered light!")
		# Add your response code here



func _on_spot_light_3d_object_exited_light(object):
	if object == self:  # Only respond if we're the object that exited
		print("Exited light!")
		# Add your response code here
