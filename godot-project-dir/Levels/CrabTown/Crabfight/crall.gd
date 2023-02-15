extends Area2D

signal paddle_hit()

const CONG_TYPE = "crab"
const DEFAULT_SPEED = 50

var _speed = DEFAULT_SPEED
export var direction = Vector2.ZERO

onready var _initial_pos = position
onready var wallBounce = get_node("WallSound")
onready var paddleBounce = get_node("PaddleSound")

func _ready():
	self.monitorable = false
	
	randomize()
	var rand_x = rand_range(-0.85, 0.85)
	self.direction = self.direction + Vector2(rand_x, 1)

func _process(delta):
	_speed += delta * 2
	self.position += _speed * delta * self.direction
	
	for obj in self.get_overlapping_areas():
		if obj.name == "shimp":
			emit_signal("paddle_hit")
			var d = Vector2(randf() * 2 - 1, -1)
			bounce(d)
			self.monitorable = true

func REVERSE(d):
	if !wallBounce.playing:
		wallBounce.play()
	self.direction = (self.direction + Vector2(0, d)).normalized()
	
func bounce(d):
	if !paddleBounce.playing:
		paddleBounce.play()
	self.direction = d
