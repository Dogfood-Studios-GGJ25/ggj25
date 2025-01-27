extends AudioStreamPlayer

const CREDITS = preload("res://Audio/Music/Credits.ogg")
const MAIN = preload("res://Audio/Music/Dropping-Down.ogg")
const TITLE = preload("res://Audio/Music/TitleScreen.ogg")

@export var max_volume : float = 5.0
@export var min_volume : float = -5.0

var music_volume: float:
	get:
		return volume_db
	set(value):
		music_volume = value
		volume_db = value

func play_music(music: AudioStream, volume = 0.0):
	
	if stream == music:
		return #we're already playing this song
	
	stream = music
	volume_db = volume
	play()
	
func play_title_screen_music():
	play_music(TITLE, 0)
	
func play_credits_music():
	play_music(CREDITS, 0)
	
func play_main_music():
	play_music(MAIN, 0)


	
