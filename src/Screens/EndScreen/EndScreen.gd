extends Node2D


signal change_scene(current_scene_name)


func _on_Button_pressed() -> void:
	emit_signal("change_scene", "end_screen")
