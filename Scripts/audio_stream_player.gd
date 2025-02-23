extends AudioStreamPlayer

const CREDITS = preload("res://Audio/Music/Credits.ogg")
const MAIN = preload("res://Audio/Music/Dropping-Down.ogg")
const TITLE = preload("res://Audio/Music/TitleScreen.ogg")

var global_music_volume : float :
	get:
		return global_music_volume
	set(value):
		global_music_volume = value
		
var global_sfx_volume : float :
	get:
		return global_sfx_volume
	set(value):
		global_music_volume = value		
		
func _ready() -> void:
	SignalBus.music_volume_changed.connect(set_music_volume)
	SignalBus.stop_music.connect(stop_all_music)
	SignalBus.sfx_volume_changed.connect(volume_changed)

func play_music(music: AudioStream, volume = 0.0):
	
	if stream == music:
		return #we're already playing this song
	
	stream = music
	volume_db = volume
	play()
	
func play_title_screen_music():
	play_music(TITLE, global_music_volume)
	
func play_credits_music():
	play_music(CREDITS, global_music_volume)
	
func play_main_music():
	play_music(MAIN, global_music_volume)

func set_music_volume(new_value):
	var db_value = linear_to_db(new_value)
	global_music_volume = db_value
	volume_db = global_music_volume
	
func set_sfx_volume(new_value):
	var db_value = linear_to_db(new_value)
	global_sfx_volume = db_value	

func stop_all_music():
	stop()

func volume_changed(new_value):
	var db_value = linear_to_db(new_value)
