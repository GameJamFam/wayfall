extends Node2D
export (Vector2) var teleport_to

var player = null
func _on_pressed_interact(_airpod):
	if player.teleporting:
		return
	# player.velocity = Vector2.ZERO
	player.position = teleport_to
	player.teleporting = true


func _on_Door_body_entered(body:Node):
	if body.name == "Player":
		body.get_node("Interactor").connect("pressed_interact", self, "_on_pressed_interact")
		player = body

func _on_Door_body_exited(body:Node):
	if body.name == "Player":
		body.get_node("Interactor").disconnect("pressed_interact", self, "_on_pressed_interact")
		if player.teleporting:
			yield(get_tree().create_timer(1), "timeout")
			player.teleporting = false
		player = null
