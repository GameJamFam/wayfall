extends MarginContainer

func _ready():
	$ColorRect.visible = false
	for item in $HBoxContainer.get_children():
		item.visible = false
		
func add_pickup(name):
	$ColorRect.visible = true
	$HBoxContainer.get_node(name).visible = true
