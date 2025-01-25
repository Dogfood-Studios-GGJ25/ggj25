extends Node
@onready var audioplayer = $"../VoicePlayer"
@onready var background = $"../Control/ColorRect"
@onready var cover = $"../Control/black cover"
@onready var title = $"../Control/Title"
@onready var ripple = $"../Control/Ripple Shader"
var audio_dict = {
	"hey": preload("res://Intro/audio/hey.mp3"),
	"listen": preload("res://Intro/audio/listen.mp3"),
	"youready1": preload("res://Intro/audio/you ready 1.mp3"),
	"youready2": preload("res://Intro/audio/you ready 2.mp3"),
	"splash": preload("res://Intro/audio/water-splash-199583.mp3"),
	"formality": preload("res://Intro/audio/formality.mp3"),
	"beintouch": preload("res://Intro/audio/be in touch.mp3"),
	"boom": preload("res://Intro/audio/boom-geomorphism-cinematic-trailer-sound-effects-123876.mp3")}

@onready var next_scene = preload("res://leveldesign.tscn")

func _ready():
	cover.visible = false
	Dialogic.signal_event.connect(_on_dialogic_signal)
	# Create a delay before starting the timeline
	await get_tree().create_timer(5.0).timeout
	Dialogic.start('introtimeline')

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
			ripple.visible = true
			title.visible = true
			await get_tree().create_timer(5.0).timeout
			
			BGMusic.play_main_music()
			# Add scene transition here
			change_scene()
	else:
		print("Error: No audio file found for", argument)

func change_scene():
	get_tree().change_scene_to_packed(next_scene)
