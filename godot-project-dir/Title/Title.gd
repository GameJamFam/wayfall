extends Control

signal start_game()

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		emit_signal("start_game")
		queue_free()