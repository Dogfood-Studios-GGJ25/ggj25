extends Node3D

var is_at_bottom := false

@export var monster_sprite : Sprite3D
@export var omni_light : OmniLight3D
const FADE_SPEED = 10

func set_is_at_bottom():
	is_at_bottom = true

func _physics_process(delta: float) -> void:
	if is_at_bottom:
		monster_sprite.modulate.a = lerp(monster_sprite.modulate.a, 255.0, delta * FADE_SPEED)
		omni_light.omni_range = lerp(omni_light.omni_range, 0.0, delta * FADE_SPEED)
		if monster_sprite.modulate.a >= 255:
			pass
			# play ending
		


func _on_temple_trigger_body_entered(body: Node3D) -> void:
	set_is_at_bottom()
