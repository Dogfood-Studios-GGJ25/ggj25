extends WorldEnvironment

func set_fog_to_eye_area():
	environment.volumetric_fog_albedo = Color(0.137, 0.136, 0.23)
	environment.volumetric_fog_emission = Color(0.003, 0.03, 0.084)
	environment.volumetric_fog_density = 0.06

func set_fog_to_abyss_area():
	environment.volumetric_fog_albedo = Color(0.225, 0.014, 0.32)
	environment.volumetric_fog_emission = Color(0, 0.006, 0.021)
	environment.volumetric_fog_density = 0.1
	
	environment.fog_enabled = true
	environment.fog_height = 0.2
	environment.fog_height_density = -.05
	environment.fog_light_color = Color(0.016, 0.161, 0.157, 0)


func _on_abyss_trigger_body_entered(body: Node3D) -> void:
	set_fog_to_abyss_area()


func _on_entering_eye_area_body_entered(body: Node3D) -> void:
	set_fog_to_eye_area()
