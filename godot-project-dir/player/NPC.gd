extends Node2D
onready var dialogic_timeline_init = self.name + "_init"
onready var dialogic_timeline_repeat = self.name + "_repeat"
export (AudioStream) var interact_start_sound
export (AudioStream) var airpod_sound

onready var dialogic_timeline = dialogic_timeline_init
var dialogue_playing = false
var dialogue = null

var player = null
func _ready():
	if airpod_sound:
		$TalkIcon/AudioStreamPlayer.set_stream(airpod_sound)

var airpod_playing = false
func airpod_interact():
	if airpod_playing:
		return
	$TalkIcon/AudioStreamPlayer.play()
	airpod_playing = true
	yield($TalkIcon/AudioStreamPlayer, "finished")
	airpod_playing = false

func _on_pressed_interact(airpod):  
	if airpod:
		airpod_interact()
		return
	if is_instance_valid(dialogue) or dialogic_timeline == "":
		return
	dialogue = Dialogic.start(dialogic_timeline)
	dialogue_playing = true
	get_tree().root.add_child(dialogue)
	player.set_input(false)
	dialogic_timeline = dialogic_timeline_repeat
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
