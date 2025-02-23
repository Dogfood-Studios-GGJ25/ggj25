extends Node
@onready var audioplayer = $"../VoicePlayer"
@onready var background = $"../Control/ColorRect"
@onready var cover = $"../Control/black cover"
@onready var title = $"../Control/Title"
@onready var ripple = $"../Control/Ripple Shader"
@onready var voice_audio = $"../VoicePlayer"
@onready var ocean_audio = $"../OceanSoundPlayer"


var audio_dict = {
	"hey": preload("res://Scenes/Intro/audio/hey.mp3"),
	"listen": preload("res://Scenes/Intro/audio/listen.mp3"),
	"youready1": preload("res://Scenes/Intro/audio/you ready 1.mp3"),
	"youready2": preload("res://Scenes/Intro/audio/you ready 2.mp3"),
	"splash": preload("res://Scenes/Intro/audio/water-splash-199583.mp3"),
	"formality": preload("res://Scenes/Intro/audio/formality.mp3"),
	"beintouch": preload("res://Scenes/Intro/audio/be in touch.mp3"),
	"boom": preload("res://Scenes/Intro/audio/boom-geomorphism-cinematic-trailer-sound-effects-123876.mp3")}

@onready var next_scene = preload("res://Scenes/Level/leveldesign.tscn")

func _ready():
	cover.visible = false
	Dialogic.signal_event.connect(_on_dialogic_signal)
	SignalBus.sfx_volume_changed.connect(sfx_volume_changed)
	
	# Create a delay before starting the timeline
	await get_tree().create_timer(2.0).timeout
	Dialogic.start('introtimeline')
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("skip"):
		Dialogic.end_timeline()
		change_scene()

func _on_dialogic_signal(argument: String):
	if audio_dict.has(argument):
		audioplayer.stop()
		audioplayer.stream = audio_dict[argument]
		audioplayer.play()
		
		# Add color change for splash signal
		if argument == "splash":
			await get_tree().create_timer(2.0).timeout
			cover.visible = true
			await get_tree().create_timer(1.0).timeout
			audioplayer.stream = audio_dict["boom"]
			audioplayer.play()
			BGMusic.play_main_music()
			ripple.visible = true
			title.visible = true
			await get_tree().create_timer(5.0).timeout
			change_scene()
	else:
		print("Error: No audio file found for", argument)

func sfx_volume_changed(new_value):
	voice_audio.volume_db = linear_to_db(new_value)
	ocean_audio.volume_db = linear_to_db(new_value)

func change_scene():
	# Add scene transition here
	if(!Dialogic.timeline_ended):
		Dialogic.end_timeline()
	BGMusic.play_main_music()
	get_tree().change_scene_to_packed(next_scene)
