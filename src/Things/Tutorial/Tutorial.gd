extends Control
tool
class_name Tutorial
signal clicked


export(String) var title: String
export(String, MULTILINE) var text: String


onready var _title: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Label
onready var _text: RichTextLabel = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
onready var _click_audio: AudioStreamPlayer = $ClickAudio


var is_visible: bool = false


func _ready():
	_title.text = title
	_text.bbcode_text = text


func show_up():
	show()

	is_visible = true

	yield(self, "clicked")


func _on_CenterContainer_gui_input(event: InputEvent) -> void:
	if not event as InputEventMouseButton or event.pressed:
		return

	get_tree().set_input_as_handled()

	_click_audio.play()
	yield(_click_audio, "finished")
	emit_signal("clicked")
	queue_free()
