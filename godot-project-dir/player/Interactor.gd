extends CollisionShape2D

signal pressed_interact(airpod)

# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	if Input.is_action_pressed("ui_interact"):
		emit_signal("pressed_interact", false)
	if Input.is_action_pressed("ui_airpod"):
		emit_signal("pressed_interact", true)