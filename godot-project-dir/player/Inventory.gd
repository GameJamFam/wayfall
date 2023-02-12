extends MarginContainer

func _ready():
	for item in $HBoxContainer.get_children():
		item.visible = false
		
func add_pickup(name):
	$HBoxContainer.get_node(name).visible = true
