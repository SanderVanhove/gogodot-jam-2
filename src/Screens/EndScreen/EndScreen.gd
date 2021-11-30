extends Node2D


signal change_scene(current_scene_name)


func _on_Button_pressed() -> void:
	emit_signal("change_scene", "end_screen")

	$EndClick.play()
	$EndMusic.stop()


func _on_Sander_gui_input(event: InputEvent) -> void:
	if not event as InputEventMouseButton or event.pressed:
		return

	OS.shell_open("https://twitter.com/SanderVhove")


func _on_Jordan_gui_input(event: InputEvent) -> void:
	if not event as InputEventMouseButton or event.pressed:
		return

	OS.shell_open("www.jordanguerette.com")


func _on_Patreon_gui_input(event: InputEvent) -> void:
	if not event as InputEventMouseButton or event.pressed:
		return

	OS.shell_open("https://www.patreon.com/sandervanhove")
