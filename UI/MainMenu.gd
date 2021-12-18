extends VideoPlayer

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer2/Selector
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer3/Selector

const first_scene = preload("res://Scenes/World.tscn")

var current_selection = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_current_selection(current_selection)

func _process(delta):
	if Input.is_action_just_pressed("ui_down") and current_selection < 2:
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_parent().add_child(first_scene.instance())
		queue_free()
	elif _current_selection == 1:
		pass
		#about creator and the game
	elif _current_selection == 2:
		get_tree().quit()

func set_current_selection(_current_selection) :
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	if _current_selection == 0:
		selector_one.text = ">"
	elif _current_selection == 1:
		selector_two.text = ">"
	elif _current_selection == 2:
		selector_three.text = ">"
	


func _on_MainMenu_finished():
	self.play()
