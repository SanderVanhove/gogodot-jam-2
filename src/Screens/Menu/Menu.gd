extends Node2D


signal change_scene(current_scene_name)


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
	emit_signal("change_scene", "menu")
