extends Node3D

@onready var player_box: Node3D = $BoundingPlayerBox

var SCROLL_SPEED = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BGMusic.play_main_music()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_box.position.y -= SCROLL_SPEED * delta
	
func stop_scrolling():
	SCROLL_SPEED = 0

func _on_temple_trigger_body_entered(body: Node3D) -> void:
	stop_scrolling()
