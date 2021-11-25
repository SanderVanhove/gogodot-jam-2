extends Camera2D


onready var _tween: Tween = $Tween


func _ready() -> void:
	_tween.interpolate_property(self, "zoom", Vector2.ONE, Vector2(1.01, 1.01), 5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	_tween.interpolate_property(self, "zoom", Vector2(1.01, 1.01), Vector2.ONE, 5, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 5)
	_tween.start()
