extends Node

const DEFAULT_MUSIC_VOLUME = 0.5
const DEFAULT_SFX_VOLUME = 0.5

func _ready() -> void:
    # Initialize volume settings from saved values or defaults
    var music_volume = _load_setting("music_volume", DEFAULT_MUSIC_VOLUME)
    var sfx_volume = _load_setting("sfx_volume", DEFAULT_SFX_VOLUME)
    
    # Emit signals to set initial volumes
    SignalBus.music_volume_changed.emit(music_volume)
    SignalBus.sfx_volume_changed.emit(sfx_volume)
    
    # Connect to volume change signals to save values
    SignalBus.music_volume_changed.connect(_on_music_volume_changed)
    SignalBus.sfx_volume_changed.connect(_on_sfx_volume_changed)

func _load_setting(key: String, default_value: float) -> float:
    if FileAccess.file_exists("user://settings.cfg"):
        var config = ConfigFile.new()
        var err = config.load("user://settings.cfg")
        if err == OK:
            return config.get_value("audio", key, default_value)
    return default_value

func _save_setting(key: String, value: float) -> void:
    var config = ConfigFile.new()
    if FileAccess.file_exists("user://settings.cfg"):
        config.load("user://settings.cfg")
    config.set_value("audio", key, value)
    config.save("user://settings.cfg")

func _on_music_volume_changed(value: float) -> void:
    _save_setting("music_volume", value)

func _on_sfx_volume_changed(value: float) -> void:
    _save_setting("sfx_volume", value) 