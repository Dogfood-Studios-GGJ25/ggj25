extends MeshInstance3D

var time: float = 0
var float_speed: float = 1.5  # Slowed down for more water-like motion
var float_height: float = 0.3  # Reduced height for gentler bobbing
var rotation_speed: float = 0.8  # Controls how fast it rotates

var original_material: Material
var bright_purple := Color(1.0, 0.0, 1.0, 1.0)  # Bright purple color

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create a unique material instance for this mesh
	original_material = material_override.duplicate()
	material_override = original_material
	
	# Connect to the spotlight's signals
	var spotlight = $"../SpotLight3D"  # Adjust this path to your spotlight
	spotlight.object_entered_light.connect(_on_spotlight_entered)
	spotlight.object_exited_light.connect(_on_spotlight_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	# Smooth floating motion
	position.y = sin(time * float_speed) * float_height
	
	# Gentle rotation around Y axis
	rotate_y(rotation_speed * delta)

func _on_spotlight_entered(object: Node3D):
	if object == self:  # Only respond if we're the object that entered
		if material_override is StandardMaterial3D:
			material_override.albedo_color = Color.WHITE
			print("Entered light!")

func _on_spotlight_exited(object: Node3D):
	if object == self:  # Only respond if we're the object that exited
		if material_override is StandardMaterial3D:
			material_override.albedo_color = bright_purple
			print("Exited light!")
