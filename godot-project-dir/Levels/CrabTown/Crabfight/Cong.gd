extends Node2D

var screen
var gogogogo = false
var bounds
var waitTime = 2

onready var cing = self.get_node("Cing")
onready var timer = $BallTimer
var crall
var crabCount = 0

func _ready():
	crall = load("res://Levels/CrabTown/Crabfight/CrabBall.tscn")
	timer.one_shot = true
	timer.wait_time = waitTime
	
	$Cing.connect("boss_hit", self, "boss_hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer.time_left == 0:
		moreCrabs()
		timer.start()
			

func moreCrabs():
		var spawnLoc = cing.position
		var newCrall = crall.instance()
		newCrall.name = newCrall.name + str(crabCount)
		newCrall.position = spawnLoc
		crabCount = crabCount + 1
		self.add_child(newCrall)
		$BallStart.play()
		
func boss_hit(_hcrall):
	print(_hcrall)
	var cnode = get_node(_hcrall)
	cnode.queue_free()
	
func wall_hit():
	$WallBounce.play()
