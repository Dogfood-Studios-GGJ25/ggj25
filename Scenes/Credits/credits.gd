extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BGMusic.play_credits_music()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Intro/intro.tscn")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
