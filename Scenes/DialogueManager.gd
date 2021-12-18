extends Control

export(NodePath) onready var _dialog_text = get_node(_dialog_text) as Label
export(NodePath) onready var _avatar = get_node(_avatar) as TextureRect
export(Resource) var _dialogue_resource = _dialogue_resource as Dialogue

onready var player_cam = get_parent().get_parent().get_node("Player/Camera")

var _current_slide_index := 0
var condition = false

func _ready():
	_avatar.texture = _dialogue_resource.avatar_texture
	show_slide()
	GameEvents.connect("dialog_initiated", self, "_on_dialog_initiated")

func _input(event):
	if Input.is_action_just_pressed("advance_slide"):
		if _current_slide_index < _dialogue_resource.dialog_slides.size() - 1:
			_current_slide_index += 1
			show_slide()
		else :
			self.visible = false

func show_slide():
	_dialog_text.text = _dialogue_resource.dialog_slides[_current_slide_index]

func _on_dialog_initiated(dialogue: Dialogue):
	_dialogue_resource = dialogue
	_avatar.texture = dialogue.avatar_texture
	_current_slide_index = 0
	self.visible = true
	show_slide()

func _on_DialogTrigger_body_exited(body):
	self.visible = false


