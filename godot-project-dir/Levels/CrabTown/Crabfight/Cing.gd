extends Area2D

signal boss_hit(crall)

const CONG_TYPE = "crab"
const DEFAULT_SPEED = 20

var _speed = DEFAULT_SPEED
var direction = Vector2.LEFT

onready var _initial_pos = position
onready var bounceSound = get_node('../WallBounce')

func _process(delta):
	_speed += delta * 2
	position += _speed * delta * direction
	
	for obj in self.get_overlapping_areas():
		if obj.name.begins_with("crall"):
			emit_signal("boss_hit", obj.name)
			
	
func REVERSE(d):
	if !bounceSound.playing:
		bounceSound.play()
	direction = (direction + Vector2(d, 0)).normalized()
