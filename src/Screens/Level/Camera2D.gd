extends Camera2D
class_name ZoomingCamera


onready var _tween: Tween = $Tween


func _ready() -> void:
	_tween.interpolate_property(self, "zoom", Vector2.ONE, Vector2(1.01, 1.01), 5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	_tween.interpolate_property(self, "zoom", Vector2(1.01, 1.01), Vector2.ONE, 5, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 5)
	_tween.start()


func zoom_to(new_position: Vector2) -> void:
	_tween.stop_all()
	_tween.remove_all()

	_tween.interpolate_property(self, "position", position, new_position, 8, Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.interpolate_property(self, "zoom", zoom, Vector2(.5, .5), 8, Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()
