extends KinematicBody2D
export (Vector2) var speed
export var gravity = 500.0
export var acceleration = 10
export var decel_x = 0.1
export var boost_amt = 200
export var boost_time = 0.5
export var boost_cooldown = 1.0

var velocity = Vector2()
var old_speed = Vector2()

var can_boost = true
func enable_boost():
	speed = old_speed
	yield(get_tree().create_timer(boost_cooldown), "timeout")
	can_boost = true

func get_input():
	velocity.y = gravity

	if Input.is_action_pressed("ui_accept") and can_boost:
		old_speed = speed
		speed.x *= boost_amt
		can_boost = false

	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + acceleration, speed.x)
		$AnimatedSprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - acceleration, -speed.x)
		$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("ui_up"):
		velocity.y = -speed.y
	elif Input.is_action_pressed("ui_down"):
		velocity.y = speed.y
	
	if !can_boost:
		yield(get_tree().create_timer(boost_time), "timeout")
		enable_boost()

	velocity.x = lerp(velocity.x, 0, decel_x)
	print(velocity)

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)	
