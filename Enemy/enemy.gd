extends Node3D

var speed = 1.0
var target_position: Vector3


func _ready() -> void:
	var flashlight = get_parent().get_parent().get_node("Player/SpringArm3D/SpotLight3D")
	print(flashlight)
	flashlight.connect("object_detected", Callable(self, "_on_object_detected"))


func _process(delta: float) -> void:
	var player = get_parent().get_parent().get_node("Player") 
	target_position = player.position
	var direction = (target_position - position).normalized()
	position += direction * speed * delta


func _on_object_detected(object: Object) -> void:
	queue_free()
