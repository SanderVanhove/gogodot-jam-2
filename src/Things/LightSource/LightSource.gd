extends Node2D
class_name LightSource


signal finish_hit


onready var _raycast: RayCast2D = $RayCast2D
onready var _light: Line2D = $Light
onready var _tween: Tween = $Tween


func _ready() -> void:
	redraw()

	_tween.interpolate_property(_light, "width", 5, 6, .3, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	_tween.interpolate_property(_light, "width", 6, 5, .3, Tween.TRANS_SINE, Tween.EASE_IN_OUT, .3)
	_tween.start()


func redraw() -> void:
	_raycast.clear_exceptions()
	_raycast.position = Vector2.ZERO
	_raycast.cast_to = Vector2(0, 1000)
	_raycast.force_raycast_update()

	var points: PoolVector2Array = PoolVector2Array([Vector2.ZERO])
	var collider: Node2D = _raycast.get_collider()
	var collider_position: Vector2 = Vector2.ZERO

	var starting_angle: float = 180
	if int(rad2deg(rotation)) == 90:
		starting_angle = 0

	var running_angle: float = starting_angle

	print()
	printt("--------------------Start calc", running_angle)

	while collider and not collider.get_parent().is_in_group("target"):
		var collider_parent: Mirror = collider.get_parent()
		print("*******", collider_parent)

		collider_position = to_local(collider_parent.position)
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

		if abs(adjustment) >= 180 and abs(adjustment) < 270 or adjustment == 0 or abs(adjustment) == 360:
			bounce_angle = 180 + bounce_angle

		if abs(bounce_angle) == 180: bounce_angle *= 2

		if incident_angle == 0 or incident_angle == 90 and abs(adjustment) == 90: bounce_angle = 180

		printt("Adjustment", adjustment)
		printt("Incident", incident_angle)
		printt("Bounce angle", bounce_angle)

		running_angle = fmod(running_angle + bounce_angle + starting_angle, 360.0)
		if running_angle < 0: running_angle += 360
		printt(running_angle, bounce_angle)

		_raycast.position = collider_position
		_raycast.cast_to = Vector2(0, 1000).rotated(deg2rad(running_angle - starting_angle))

		_raycast.clear_exceptions()
		_raycast.add_exception(collider)
		_raycast.force_raycast_update()

		collider = _raycast.get_collider()

	if collider and collider.get_parent().is_in_group("target"):
		points.append(to_local(collider.get_parent().position))
		emit_signal("finish_hit")
	else:
		points.append(_raycast.cast_to + collider_position)

	_light.points = points
