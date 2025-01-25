extends CharacterBody3D

@onready var spring_arm = $SpringArm3D
@onready var spotlight = $SpringArm3D/SpotLight3D
@onready var oxy_level: Label3D = $OxyLevel

@export var oxygen_level : int = 100

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
	update_o2_label()

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

	interact_with_bubbles()
	move_and_slide()

func update_o2_label():
	oxy_level.text = "O2: " + str(oxygen_level)

func interact_with_bubbles() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is Bubble:
			var o2_gained = collider.pop_for_oxygen()
			oxygen_level += o2_gained
			update_o2_label()

func on_interact(state):
	match state:
		"quick_time":
			print("QUICK TIME START")
		"Jumpscare":
			print("JUMPSCARE START")


func _on_spot_light_3d_object_detected(object: Variant) -> void:
	print("Detected object in spotlight:", object)
