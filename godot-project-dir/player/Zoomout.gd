extends Node2D

func _on_Area2D_body_exited(body:Node):
    if body.name == "Player":
        body.get_node("Camera/AnimationPlayer").play_backwards("Zoom")


func _on_Area2D_body_entered(body:Node):
    if body.name == "Player":
        body.get_node("Camera/AnimationPlayer").play("Zoom")

