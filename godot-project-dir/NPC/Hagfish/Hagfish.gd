extends Node2D
export var travel_distance_fwd = 0

onready var kinebody = $KinematicBody2D
onready var dangerzone = get_node("AttackArea")
onready var anim = $AnimationPlayer

var charging = false

func _on_AttackArea_body_entered(body:Node):
	if body.name == "Player" and not charging:
		body.set_input(false)
		charge(body)

func charge(body:Node):
	charging = true
	anim.play("Charge")
	yield(anim, "animation_finished")
	charging = false
	body.set_input(true)
