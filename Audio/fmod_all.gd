extends Node3D

@onready var sfx = $FmodBankLoader/EnvironmentNoise

func _ready() -> void:
	SignalBus.sfx_volume_changed.connect(volume_changed)
	
func volume_changed(new_value):
	sfx.volume = new_value
