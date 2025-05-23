extends TextureButton

@onready var settings_panel : Panel = $SettingsPanel
@onready var music_slider : HSlider = $SettingsPanel/MusicVolSlider
@onready var sfx_slider : HSlider = $SettingsPanel/SFXVolSlider

@export var has_visible_icon : bool = true

func _ready() -> void:
	SignalBus.open_settings.connect(_test)
	if not has_visible_icon:
		visible = false

func _test() -> void:
	print("Yo!")
	pass

func _on_pressed() -> void:
	if not settings_panel.visible:
		# Load saved values when opening settings
		var config = ConfigFile.new()
		if FileAccess.file_exists("user://settings.cfg"):
			var err = config.load("user://settings.cfg")
			if err == OK:
				music_slider.value = config.get_value("audio", "music_volume", 0.5) * 100
				sfx_slider.value = config.get_value("audio", "sfx_volume", 0.5) * 100
		settings_panel.show()
		
func _on_close_button_pressed() -> void:
	# store all settings
	
	#close the panel
	settings_panel.hide()

func _on_music_vol_slider_value_changed(value: float) -> void:
	SignalBus.music_volume_changed.emit(value / 100.0)

func _on_sfx_vol_slider_value_changed(value: float) -> void:
	SignalBus.sfx_volume_changed.emit(value / 100.0)
