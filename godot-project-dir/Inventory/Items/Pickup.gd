extends Node2D
export (AudioStream) var pickup_sound
onready var anim = get_node("Sprite/AnimationPlayer")

var wiggle_timer
var player = null
var dialogue = null


func _ready():
	anim.play("Wiggle")


func _on_pressed_interact(_airpod):
	if is_instance_valid(dialogue):
		return
	dialogue = Dialogic.start(self.name)
	add_child(dialogue)
	player.set_input(false)
	anim.play("Pickup")
	yield(anim, "animation_finished")
	player.get_node("Camera/Canvas/Inventory").add_pickup(self.name)
	yield(dialogue, "timeline_end")
	player.set_input(true)
	queue_free()


func _on_InteractArea_body_exited(body:Node):
	if body.name == "Player":
		body.get_node("Interactor").disconnect("pressed_interact", self, "_on_pressed_interact")
		player = null

func _on_InteractArea_body_entered(body:Node):
	if body.name == "Player":
		body.get_node("Interactor").connect("pressed_interact", self, "_on_pressed_interact")
		player = body
