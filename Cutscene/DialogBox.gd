extends Control

var dialog = []

var dialog_index = 0
var finished = false
 
func _ready():
	self.visible = false
	load_dialog()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog():
	$IconIndicator.visible = finished
	if dialog_index < dialog.size():
		finished = true
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property($RichTextLabel,"percent_visible", 0, 1, 1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		#self.visible = false
		queue_free()
	dialog_index += 1

func set_visibility():
	self.visible = true

func _on_Tween_tween_completed(object, key):
	finished = true
