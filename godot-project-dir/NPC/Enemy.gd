extends Node2D

func _on_HurtArea_body_entered(body:Node):
	if body.name == "Player":
		body.get_node("Camera/Canvas/Lives").hurt_player(1)
