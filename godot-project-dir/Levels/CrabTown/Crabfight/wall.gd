extends Area2D

signal wall_hit()

export var _bounce_direction = 1
export var _wall = "left"

func _process(delta):
	for thing in self.get_overlapping_areas():
		if thing.name == "Cing" || thing.name.begins_with("crall"):
			thing.REVERSE(_bounce_direction)
		else:
			thing.against_wall(_wall)
			emit_signal("wall_hit")
