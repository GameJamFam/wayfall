extends Area2D

const MOVE_SPEED = 300

var _ball_dir
var _against_wall


func _ready():
	_ball_dir = -1
	

func _process(delta):
	
	if Input.is_action_pressed("ui_left") && _against_wall != "left":
		position.x = position.x - MOVE_SPEED * delta
	if Input.is_action_pressed("ui_right") && _against_wall != "right":
		position.x = position.x + MOVE_SPEED * delta 

#	for ball in self.get_overlapping_areas():
#		print(ball.name)
#		if ball.name.begins_with("crall"):
#			var d = Vector2(randf() * 2 - 1, _ball_dir)
#			ball.bounce(d)
	
func against_wall(wall):
	_against_wall = wall
