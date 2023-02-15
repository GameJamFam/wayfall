extends Node2D

func _on_CKPT_body_entered(body:Node):
	if body.name == "Player":
		body.checkpoint_set(self.position)