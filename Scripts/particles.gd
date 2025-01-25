extends Node3D

@export var particle_count := 1000
@export var spawn_region := Vector3(20, 10, 20)
@export var particle_size := Vector2(0.05, 0.15)
@export var particle_color := Color(1, 1, 1, 0.3)
@export var float_speed := 0.2
@export var player_influence := 0.3

@onready var player: CharacterBody3D = $"../../BoundingPlayerBox/Player"

var particles: MultiMesh
var time := 0.0


func _ready():
	# Create particle system
	var particle_mesh = QuadMesh.new()
	particle_mesh.size = 0.1 * Vector2.ONE
	
	particles = MultiMesh.new()
	particles.transform_format = MultiMesh.TRANSFORM_3D
	particles.mesh = particle_mesh
	particles.instance_count = particle_count
	
	# Create multimesh instance
	var mi = MultiMeshInstance3D.new()
	mi.multimesh = particles
	add_child(mi)
	
	# Create material
	var material = StandardMaterial3D.new()
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.vertex_color_use_as_albedo = true
	material.billboard_mode = BaseMaterial3D.BILLBOARD_ENABLED
	particle_mesh.surface_set_material(0, material)
	
	# Initialize particles
	for i in particle_count:
		var pos = Vector3(
			randf_range(-spawn_region.x, spawn_region.x),
			randf_range(-spawn_region.y, spawn_region.y),
			randf_range(-spawn_region.z, spawn_region.z)
		)
		var size = 0.01 * randf_range(particle_size.x, particle_size.y)
		var transform = Transform3D(Basis.IDENTITY.scaled(Vector3(size, size, size)), pos)
		particles.set_instance_transform(i, transform)

func _process(delta):
	time += delta
	var player_velocity = Vector3.ZERO
	if player:
		player_velocity = -player.velocity * player_influence
	
	# Update particles
	for i in particle_count:
		var transform = particles.get_instance_transform(i)
		var pos = transform.origin
		
		# Float upward and reset when out of bounds
		pos.y += float_speed * delta
		if pos.y > spawn_region.y:
			pos.y = -spawn_region.y
			
		# Apply player movement influence
		pos += player_velocity * delta
		
		# Wrap particles horizontally
		if pos.x > spawn_region.x: pos.x = -spawn_region.x
		elif pos.x < -spawn_region.x: pos.x = spawn_region.x
		if pos.z > spawn_region.z: pos.z = -spawn_region.z
		elif pos.z < -spawn_region.z: pos.z = spawn_region.z
		
		transform.origin = pos
		particles.set_instance_transform(i, transform)

# Call this to set the player reference for movement influence
func set_player(player_node: Node3D):
	player = player_node
