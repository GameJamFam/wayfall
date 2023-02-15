extends Node2D

signal game_over()

var health

# Called when the node enters the scene tree for the first time.
func _ready():
	health = get_child_count() - 1
	self.get_parent().get_node("CRT/Cong/Cing").connect("boss_hit", self, "_boss_hit")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _boss_hit(_crall):
	if health <= 0:
		emit_signal("game_over")
	else:
		var point = get_node("tick" + str(health))
		point.queue_free()
		health -= 1
