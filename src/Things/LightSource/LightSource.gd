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
	var collider_position: Vector2 = Vector2.ZERO

	var starting_angle: float = 180 + rad2deg(rotation)
	var running_angle: float = starting_angle

	print()
	printt("--------------------Start calc", running_angle)

	while collider:
		var collider_parent: Mirror = collider.get_parent()
		print("*******", collider_parent)

		collider_position = to_local(collider_parent.bounce_position)
		points.append(collider_position)

		var collider_angle: float = collider_parent.angle
		if collider_angle < 0: collider_angle += 360

		printt(collider_angle, running_angle)
		var incident_angle: float = running_angle - collider_angle
		var adjustment: float = 0.0

		while incident_angle > 90 or incident_angle < 0:
			adjustment += 90 if incident_angle < 90 else - 90
			incident_angle += 90 if incident_angle < 90 else - 90

		var bounce_angle: float = -incident_angle * 2

		if abs(adjustment) >= 180 and abs(adjustment) < 270 or adjustment == 0:
			bounce_angle = 180 + bounce_angle

		if abs(bounce_angle) == 180: bounce_angle *= 2

		if incident_angle == 0 or incident_angle == 90 and abs(adjustment) == 90: bounce_angle = 180

		printt("Adjustment", adjustment)
		printt("Incident", incident_angle)
		printt("Bounce angle", bounce_angle)

		#var bounce_angle: float = rad2deg(Vector2(0, 1).rotated(deg2rad(fake_angle)).reflect(Vector2(0, 1).rotated(deg2rad(collider_parent.angle))).angle())
		running_angle = fmod(running_angle + bounce_angle + starting_angle, 360.0)
		if running_angle < 0: running_angle += 360
		printt(running_angle, bounce_angle)

		_raycast.position = collider_position
		#_raycast.cast_to = Vector2(0, 1000).rotated(deg2rad(running_angle)) + collider_position
		_raycast.cast_to = Vector2(0, 1000).rotated(deg2rad(running_angle - starting_angle))

		_raycast.clear_exceptions()
		_raycast.add_exception(collider)
		_raycast.force_raycast_update()

		collider = _raycast.get_collider()

	points.append(_raycast.cast_to + collider_position)

	_light.points = points
