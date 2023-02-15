extends KinematicBody2D
export (Vector2) var speed
export var gravity = 500.0
export var acceleration = 10
export var decel_x = 0.1
export var boost_amt = 200
export var boost_time = 0.5
export var boost_cooldown = 1.0

onready var last_checkpoint = position
onready var sprite = $AnimatedSprite

var velocity = Vector2()
var old_speed = Vector2()

var can_boost = true
func enable_boost():
	speed = old_speed
	$AnimatedSprite.play("default")
	rotation = 0
	yield(get_tree().create_timer(boost_cooldown), "timeout")
	can_boost = true

var can_move = true
func set_input(state):
	can_move = state
	if not can_move:
		bob()
	else:
		$AnimationPlayer.stop()


export var bob_velocity = -10
export var bob_timeout = 0.4
func bob():
	if can_move:
		return
	$AnimationPlayer.play("Bob")

	# velocity.x = 0
	# if bobbing:
	# 	velocity.y = bob_velocity
	# 	yield(get_tree().create_timer(bob_timeout), "timeout")
	# 	bobbing = false
	# else:
	# 	velocity.y = gravity
	# 	yield(get_tree().create_timer(bob_timeout), "timeout")
	# 	bobbing = true
		

var teleporting = false
func go_to_last_checkpoint():
	position = last_checkpoint

func _on_checkpoint_set(pos:Vector2):
	last_checkpoint = pos

func get_input():
	velocity.y = gravity

	if Input.is_action_pressed("ui_accept") and can_boost:
		old_speed = speed
		speed.x *= boost_amt
		can_boost = false
		$AnimatedSprite.play("dash")
		rotation = 45 if Input.is_action_pressed("ui_right") else -45

	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + acceleration, speed.x)
		sprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - acceleration, -speed.x)
		sprite.flip_h = true
	if Input.is_action_pressed("ui_up"):
		velocity.y = -speed.y
	elif Input.is_action_pressed("ui_down"):
		velocity.y = speed.y
	
	if !can_boost:
		yield(get_tree().create_timer(boost_time), "timeout")
		enable_boost()

	velocity.x = lerp(velocity.x, 0, decel_x)

func _physics_process(delta):
	if can_move:
		get_input()
		velocity = move_and_slide(velocity)

