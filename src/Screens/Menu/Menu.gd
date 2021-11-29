extends Node2D



func _on_Label2_gui_input(event: InputEvent) -> void:
	if not event as InputEventMouseButton or event.pressed:
		return

	OS.shell_open("https://twitter.com/SanderVhove")


func _on_Jordan_gui_input(event: InputEvent) -> void:
	if not event as InputEventMouseButton or event.pressed:
		return

	OS.shell_open("https://twitter.com/jordanguerette")


func _on_patreon_gui_input(event: InputEvent) -> void:
	if not event as InputEventMouseButton or event.pressed:
		return

	OS.shell_open("https://www.patreon.com/sandervanhove")


func _on_Button_pressed() -> void:
	get_tree().change_scene("res://Screens/Level/Level.tscn")
