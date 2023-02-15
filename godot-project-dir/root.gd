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
export (AudioStream) var bgm_shrimp_party
export (AudioStream) var bgm_isopod
export (AudioStream) var bgm_cucumber


onready var audio = {
	bgm={
		"title":bgm_title,
		"crab":bgm_crab,
		"crab_heavy":bgm_crab_heavy,
		"shrimp":bgm_shrimp,
		"party":bgm_shrimp_party,
		"isopod":bgm_isopod,
		"cucumber":bgm_cucumber,
	},
	amb={
		"click":ambience_click,
		"basic":ambience_basic,
	},
}

func set_bgm(bgm_name):
	if $BGM.playing:
		$BGM.stop()
	if bgm_name != "":
		var s = audio["bgm"][bgm_name]
		print(s)
		$BGM.set_stream(s)
		$BGM.play()
		print($BGM.playing)

func set_amb(amb_name):
	$AMBIENCE.stop()
	var s = audio['amb'][amb_name]
	if s:
		$AMBIENCE.set_stream(s)
		$AMBIENCE.play()


# Called when the node enters the scene tree for the first time.
func _ready():
	set_bgm("title")
	get_node("Title").connect("start_game", self, "load_main_level")

var main = null
func load_main_level():
	main = main_levels.instance()
	add_child(main)
	set_amb("click")
	set_bgm("shrimp")

var crab = null
func load_crab_fight():
	set_bgm("crab_heavy")
	main.get_node("Player").set_input(false)
	main.get_node("Player/Camera").current = false
	crab = crab_fight.instance()
	add_child(crab)
	yield(crab.get_node("Health"), "game_over")
	get_tree().paused = false
	crab.queue_free()
	$BGM.stop()
	main.get_node("Player/Camera").current = true
	main.get_node("Player").set_input(true)


