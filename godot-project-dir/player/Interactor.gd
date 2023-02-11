extends CollisionShape2D

signal pressed_interact

func has_airpod():
	pass

# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	if Input.is_action_pressed("ui_interact"):
		emit_signal("pressed_interact")