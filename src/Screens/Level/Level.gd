extends Node2D


var _dragging_mirror: Mirror
var _hovering_grid_cell: GridCell


var _mirrors: Array = []
var _grid_cells: Array = []
onready var _light_source: LightSource = $LightSource


func _ready() -> void:
	_mirrors = $Mirrors.get_children()
	_grid_cells = $Grid.get_children()

	for mirror in _mirrors:
		mirror.connect("clicked", self, "mirror_clicked")
		mirror.connect("dropped", self, "mirror_dropped")

	for grid_cell in _grid_cells:
		grid_cell.connect("mouse_over", self, "mouse_over_grid_cell")
		grid_cell.connect("mouse_out", self, "mouse_out_grid_cell")

	_light_source.connect("finish_hit", self, "level_ended")


func mirror_clicked(mirror: Mirror) -> void:
	$MirrorPickup.play()
	
	if _dragging_mirror:
		return

	_dragging_mirror = mirror
	_dragging_mirror.is_held = true

	if _dragging_mirror.current_cell:
		_dragging_mirror.current_cell.has_mirror = false
		_dragging_mirror.current_cell = null

		if _hovering_grid_cell:
			_hovering_grid_cell.change_highlight(true)

	_light_source.redraw()
	num_placed_mirrors_changed()


func mirror_dropped(mirror: Mirror) -> void:
	if not _dragging_mirror or mirror != _dragging_mirror:
		return

	_dragging_mirror.is_held = false

	if _hovering_grid_cell and _hovering_grid_cell.can_accept_mirror():
		_dragging_mirror.current_cell = _hovering_grid_cell
		_dragging_mirror.set_can_bounce_light()
		_dragging_mirror.set_position(_hovering_grid_cell.position)
		_hovering_grid_cell.has_mirror = true
		_hovering_grid_cell.change_highlight(false)

		# Drops in grid cell
		$MirrorInGrid.play()
		$MirrorDrop.play()
		
	else:
		_dragging_mirror.reset_position()

		# Drops, but returns to original position
		$MirrorDrop.play()

	_dragging_mirror = null

	num_placed_mirrors_changed()

	yield(get_tree(), "idle_frame")
	_light_source.redraw()


func mouse_over_grid_cell(grid_cell) -> void:
	_hovering_grid_cell = grid_cell

	if _dragging_mirror:
		_hovering_grid_cell.change_highlight(true)


func mouse_out_grid_cell(grid_cell) -> void:
	if _hovering_grid_cell == grid_cell:
		_hovering_grid_cell = null


func level_ended() -> void:
	print("Level completed!")
	$LevelComplete.play()
	$MusicLayer1.stop()
	
func num_placed_mirrors_changed() -> void:
	var num_placed_mirrors: int = 0
	for mirror in _mirrors:
		if mirror.current_cell: num_placed_mirrors += 1

	# @Jordan, here you can place code to check how many mirrors are in place
	# if num_placed_mirrors >= 3:
	#     $MusicLayer2.set_volume(0)
	#	play some sounds
	#if num_placed_mirrors >= 6:
	#	play another sound


func _on_Timer_timeout():
	$MusicLayer1.play()
