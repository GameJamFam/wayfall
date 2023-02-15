extends Control
export (Vector2) var travel_to
var hovering = false

func _on_TravelTo_mouse_entered():
	hovering = true

func _on_TravelTo_mouse_exited():
	hovering = false

func _process(_delta):
	if hovering and Input.is_mouse_button_pressed(BUTTON_LEFT):
		var player = get_node("../../../../..")
		player.position = travel_to
		player.get_node("Camera/Canvas/MAP").visible = false
