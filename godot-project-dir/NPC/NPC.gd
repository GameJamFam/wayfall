extends Node2D
export var dialogic_timeline = ""
export (AudioStream) var interact_start_sound
export (AudioStream) var airpod_sound

var dialogue_playing = false
var dialogue = null

var player = null

func _on_pressed_interact():
	if is_instance_valid(dialogue) or dialogic_timeline == "":
		return
	dialogue = Dialogic.start(dialogic_timeline)
	dialogue_playing = true
	add_child(dialogue)
	player.set_input(false)
	dialogic_timeline = ""
	yield(dialogue, "timeline_end")
	player.set_input(true)


func _on_InteractionSphere_body_exited(body:Node):
	if body.name == "Player":
		body.get_node("Interactor").disconnect("pressed_interact", self, "_on_pressed_interact")
		player = null


func _on_InteractionSphere_body_entered(body:Node):
	if body.name == "Player":
		body.get_node("Interactor").connect("pressed_interact", self, "_on_pressed_interact")
		player = body
