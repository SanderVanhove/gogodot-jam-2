extends Node2D
class_name LightSource


onready var _raycast: RayCast2D = $RayCast2D
onready var _light: Line2D = $Light


func _ready() -> void:
	redraw()


func redraw() -> void:
	_raycast.clear_exceptions()
	_raycast.position = Vector2.ZERO
	_raycast.cast_to = Vector2(0, 1000)
	_raycast.force_raycast_update()

	var points: PoolVector2Array = PoolVector2Array([Vector2.ZERO])
	var collider: Node2D = _raycast.get_collider()

	var running_angle: float = 0

	while collider:
		var collider_parent: Mirror = collider.get_parent()

		var collider_position: Vector2 = to_local(collider_parent.bounce_position)
		points.append(collider_position)

		var bounce_angle: float = collider_parent.angle + 45
		if running_angle < 180:
			bounce_angle += 180

		running_angle += bounce_angle
		running_angle = fmod(running_angle, 360.0)

		_raycast.position = collider_position
		_raycast.cast_to = Vector2(0, 1000).rotated(deg2rad(running_angle)) + collider_position

		_raycast.add_exception(collider)
		_raycast.force_raycast_update()

		collider = _raycast.get_collider()

	points.append(_raycast.cast_to)

	_light.points = points
