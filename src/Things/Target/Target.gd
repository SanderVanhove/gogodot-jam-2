extends Node2D
class_name Target


onready var _tween: Tween = $Tween
onready var _tween2: Tween = $Tween2
onready var _win_tween: Tween = $WinTween
onready var _visual: Node2D = $Visual
onready var _default_sprite: Sprite = $Visual/Default
onready var _win_sprite: Sprite = $Visual/Win
onready var _particles: CPUParticles2D = $Visual/CPUParticles2D


func _ready() -> void:
	_win_sprite.hide()

	var delta_move: float = 4.0
	var time: float = 5.0
	_tween.interpolate_property(_visual, "position:y", -delta_move, delta_move, time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	_tween.interpolate_property(_visual, "position:y", delta_move, -delta_move, time, Tween.TRANS_SINE, Tween.EASE_IN_OUT, time)

	_tween2.interpolate_property(_visual, "rotation", .16, -.16, 6, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	_tween2.interpolate_property(_visual, "rotation", -.16, .16, 6, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 6)

	_tween.start()
	_tween2.start()


func set_win() -> void:
	_default_sprite.hide()
	_win_sprite.show()

	_win_tween.interpolate_property(self, "scale", scale, Vector2(1.6, 1.6), .3, Tween.TRANS_BACK, Tween.EASE_OUT)
	_win_tween.start()

	_particles.emitting = true
