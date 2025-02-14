extends Node3D

var timer = 4
var stress = 0
var breathState = 0
var breathTiming = [3, 2.3, 1.5, 1, 0.8]
var ScaryTimer = 0

func _ready():
	SignalBus.Oxygen_Changed.connect(OnOxygenChanged)

func _process(delta: float) -> void:
	timer += delta
	ScaryTimer += delta
	if(timer > breathTiming[stress] && breathState == 0):
		get_node("BreathEmitter").set_parameter("state", stress)
		get_node("BreathEmitter").play()
		timer = 0
		breathState = 1
	if(timer > breathTiming[stress]/1.6 && breathState == 1):
		get_node("BubbleEmitter").set_parameter("state", stress)
		get_node("BubbleEmitter").play()
		timer = 0
		breathState = 0
	if(timer > breathTiming[stress] && breathState == 2):
		get_node("BreathEmitter").set_parameter("state", 5)
		get_node("BreathEmitter").play()
		timer = 0
		breathState = 3
	if ScaryTimer > 285:
		get_node("ScaryEventEmitter").play()
		ScaryTimer = 0
		
func IncreaseStress() -> void:
	stress += 1
	if(stress > 4): stress = 4

func DecreaseStress() -> void:
	stress -= 1
	if(stress < 0): stress = 0
	
func SetStressLevel(level: int) -> void:
	stress = level
	
func OnOxygenChanged(oxygen_level: int) -> void:
	#print("oxy = ", oxygen_level)
	if oxygen_level == 0:
		breathState = 2
	if oxygen_level < 10:
		SetStressLevel(4)
	elif oxygen_level < 30:
		SetStressLevel(3)
	elif oxygen_level < 50:
		SetStressLevel(2)
	elif oxygen_level < 70:
		SetStressLevel(1)
	else:
		SetStressLevel(0)
		
