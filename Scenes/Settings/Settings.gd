extends TextureButton

@onready var settings_panel : Panel = $SettingsPanel

func _on_pressed() -> void:
	if not settings_panel.visible:
		settings_panel.show()
		
func _on_close_button_pressed() -> void:
	# store all settings
	
	#close the panel
	settings_panel.hide()

func _on_music_vol_slider_value_changed(value: float) -> void:
	SignalBus.music_volume_changed.emit(value)

func _on_sfx_vol_slider_value_changed(value: float) -> void:
	SignalBus.sfx_volume_changed.emit(value)
