extends Node3D

@onready var enemy = preload("res://Enemy/Enemy.tscn")
var spawn_radius = 5.0
var spawn_distance = 8.0
var spawn_timer: Timer

func _ready() -> void:
	spawn_timer = Timer.new()
	spawn_timer.wait_time = 10.0
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout")) 
	add_child(spawn_timer)
	spawn_timer.start()
	spawn_enemy()

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy() -> void:
	print("enemy spawned")
	var angle = randf_range(0, 2 * PI) # Random angle for circular spawning
	var spawn_position = Vector3(cos(angle) * spawn_distance, sin(angle) * spawn_distance, 0) # Calculate position based on angle
	var enemy_instance = enemy.instantiate()
	enemy_instance.position = spawn_position
	add_child(enemy_instance)
