extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_parent().get_node("CRT/Cong/Cing").connect("boss_hit", self, "_boss_hit")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _boss_hit(crall):
	pass
