extends Node2D

export (float) var wait_time_to_hurt = 0.0
export (bool) var random_rotate = false

func _ready():
	if random_rotate:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		rotation_degrees = rng.randf_range(-180.0, 180.0)

var overlapping_player = false

func _on_HurtArea_body_exited(body:Node):
	if body.name == "Player":
		overlapping_player = false

func hurt_on_timer(body): # can only recurse for 3 times, then the player runs out of health
	yield(get_tree().create_timer(wait_time_to_hurt), "timeout")
	if overlapping_player: # exiting can avoid this
		body.get_node("Camera/Canvas/Lives").hurt_player(1)
	hurt_on_timer(body)

func _on_HurtArea_body_entered(body:Node):
	if body.name == "Player":
		if wait_time_to_hurt:
			overlapping_player = true
			hurt_on_timer(body)

		else:
			body.get_node("Camera/Canvas/Lives").hurt_player(1)
