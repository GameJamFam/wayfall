extends Node

# Scenes
export (PackedScene) var main_levels
export (PackedScene) var crab_fight

export (AudioStream) var ambience_click
export (AudioStream) var ambience_basic

export (AudioStream) var bgm_title
export (AudioStream) var bgm_crab
export (AudioStream) var bgm_crab_heavy
export (AudioStream) var bgm_shrimp
export (AudioStream) var bgm_isopod
export (AudioStream) var bgm_cucumber

onready var bgm_player = $BGM
onready var amb_player = $AMBIENCE

var audio = {
	bgm={
		"title":bgm_title,
		"crab":bgm_crab,
		"crab_heavy":bgm_crab_heavy,
		"shrimp":bgm_shrimp,
		"isopod":bgm_isopod,
		"cucumber":bgm_cucumber,
	},
	amb={
		"click":ambience_click,
		"basic":ambience_basic,
	},
}

func set_bgm(bgm_name):
	bgm_player.stop()
	var s = audio['bgm'][bgm_name]
	if s:
		bgm_player.set_stream(s)
		bgm_player.play()

func set_amb(amb_name):
	amb_player.stop()
	var s = audio['amb'][amb_name]
	if s:
		amb_player.set_stream(s)
		amb_player.play()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func load_crab_fight():
	print("CRABS")
