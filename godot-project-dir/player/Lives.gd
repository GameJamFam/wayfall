extends HBoxContainer

onready var player = get_node("../../..") # terrible
const MAX_HEARTS = 3
var current_health = 3


func _ready():
	var wipe_anim = get_node("../Wipe/AnimationPlayer")
	wipe_anim.play("CircleWipe")


func die():
	player.set_input(false)
	get_child(0).visible = false
	# 1. Wipe screen
	var wipe_anim = get_node("../Wipe/AnimationPlayer")
	wipe_anim.play_backwards("CircleWipe")
	yield(wipe_anim, "animation_finished")

	# 2. Reset Health
	current_health = MAX_HEARTS
	for life in get_children():
		life.visible = true
	
	# 3. Reset pos
	player.go_to_last_checkpoint()

	# 4. Unwipe screen
	wipe_anim.play("CircleWipe")
	player.set_input(true)


func hurt_player(dmg):
	current_health -= dmg
	if current_health < 1:
		die()
	else:
		var lives = get_children()
		for life in range(0, get_child_count()):
			if life < current_health:
				lives[life].visible = true
			else:
				lives[life].visible = false
	

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		hurt_player(1)
