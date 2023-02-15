extends Node2D

var player = null
func _on_pressed_interact(_airpod):
	player.get_node("Camera/Canvas/MAP").visible = true


func _on_Door_body_entered(body:Node):
	if body.name == "Player":
		body.get_node("Interactor").connect("pressed_interact", self, "_on_pressed_interact")
		player = body

func _on_Door_body_exited(body:Node):
	if body.name == "Player":
		body.get_node("Interactor").disconnect("pressed_interact", self, "_on_pressed_interact")
		player = null
