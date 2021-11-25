extends Node2D
class_name Mirror


signal clicked(mirror)
signal dropped(mirror)


export(float) var angle = 0.0


var is_held: bool = false
var current_cell: GridCell


onready var _start_position: Vector2 = position
onready var _mirror_sprite: Sprite = $Visual/Mirror
onready var _click_area: Area2D = $Area2D
onready var _tween: Tween = $Tween
onready var _visual: Node2D = $Visual


func _ready() -> void:
	_mirror_sprite.rotate(deg2rad(angle))


func _process(delta: float) -> void:
	if is_held:
		global_position = get_global_mouse_position()
		z_index = 100
	else:
		z_index = 0


func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not event is InputEventMouseButton or not event.button_index == BUTTON_LEFT:
		return

	if Input.is_action_just_pressed("click"):
		_click_area.set_collision_layer_bit(1, false)
		emit_signal("clicked", self)
		_tween.interpolate_property(_visual, "scale", Vector2.ONE, Vector2(1.1, 1.1), .2, Tween.TRANS_BACK, Tween.EASE_OUT)
		_tween.start()

	if Input.is_action_just_released("click"):
		emit_signal("dropped", self)
		_tween.interpolate_property(_visual, "scale", Vector2(1.1, 1.1), Vector2.ONE, .2, Tween.TRANS_BACK, Tween.EASE_OUT)
		_tween.start()


func set_can_bounce_light() -> void:
	_click_area.set_collision_layer_bit(1, true)


func reset_position() -> void:
	set_position(_start_position)


func set_position(new_position: Vector2) -> void:
	_tween.interpolate_property(_visual, "position", position - new_position, Vector2.ZERO, .2, Tween.TRANS_BACK, Tween.EASE_OUT)
	_tween.start()

	position = new_position


