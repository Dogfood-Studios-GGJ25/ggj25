extends Node2D

@onready var volume_music: HSlider = $CanvasLayer/SettingsPanel/VolumeMusic

var music_volume_at_open : float

signal SettingChanged(settingName : String, newValue : Variant)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BGMusic.play_title_screen_music()
	#first we store the current settings, so we can revert if needed
	music_volume_at_open = BGMusic.music_volume
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_cancel_button_pressed() -> void:
	# ignore the settings and go back 
	BGMusic.music_volume = music_volume_at_open
	get_tree().change_scene_to_file("res://UI/StartScreen.tscn")

func _on_save_button_pressed() -> void:
	# set music_volume 	wx		
	get_tree().change_scene_to_file("res://UI/StartScreen.tscn")

func _on_volume_music_drag_ended(value_changed: bool) -> void:
	BGMusic.music_volume = volume_music.value
