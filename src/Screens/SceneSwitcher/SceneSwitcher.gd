extends Node2D


onready var current_scene = $Menu

onready var _tween: Tween = $CanvasLayer/Tween
onready var _swirl_transition_shader: ColorRect = $CanvasLayer/Swirl
onready var _wall_transition_shader: ColorRect = $CanvasLayer/Wall


func _ready() -> void:
	current_scene.connect("change_scene", self, "handle_scene_switch")


func handle_scene_switch(current_scene_name) -> void:
	var next_scene
	var shader_material

	match current_scene_name:
		"menu":
			next_scene = load("res://Screens/Level/Level_1.tscn")
			shader_material = _wall_transition_shader
		"level_1":
			next_scene = load("res://Screens/Level/Level_2.tscn")
			shader_material = _swirl_transition_shader
		"level_2":
			next_scene = load("res://Screens/EndScreen/EndScreen.tscn")
			shader_material = _swirl_transition_shader
		"end_screen":
			next_scene = load("res://Screens/Menu/Menu.tscn")
			shader_material = _wall_transition_shader
		_:
			return

	shader_material.modulate.a = 1
	shader_material.get_material().set_shader_param("fill", -0.01)

	_tween.interpolate_property(shader_material.get_material(), "shader_param/fill", -0.01, 1, .5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	current_scene.queue_free()

	current_scene = next_scene.instance()
	current_scene.connect("change_scene", self, "handle_scene_switch")
	add_child(current_scene)

	_tween.interpolate_property(shader_material, "modulate:a", 1, 0, .4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

