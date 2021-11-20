extends Node2D
class_name GridCell


signal mouse_over(grid_cell)
signal mouse_out(grid_cell)


var has_mirror: bool


onready var _tween: Tween = $Tween
onready var _background: Sprite = $Visual/Background


func can_accept_mirror() -> bool:
	return not has_mirror


func _on_Area2D_mouse_entered() -> void:
	emit_signal("mouse_over", self)


func _on_Area2D_mouse_exited() -> void:
	emit_signal("mouse_out", self)

	if _background.modulate.a > 0:
		change_highlight(false)



func change_highlight(should_highlight: bool) -> void:
	if should_highlight and can_accept_mirror():
		_tween.interpolate_property(_background, "modulate:a", 0, .2, .2)
	elif not should_highlight and _background.modulate.a > 0:
		_tween.interpolate_property(_background, "modulate:a", .2, 0, .2)
	_tween.start()
