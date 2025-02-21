extends Node3D

@onready var toprock = $SM_LittleRock_01
@onready var botrock = $SM_LittleRock_03

func open():
	# Create tween for smooth movement
	var tween = create_tween()
	
	# Move top rock up by 3 units over 1 second
	tween.parallel().tween_property(toprock, "position:y", toprock.position.y + 3, 1.0)
	# Move bottom rock down by 3 units over 1 second
	tween.parallel().tween_property(botrock, "position:y", botrock.position.y - 3, 1.0)
