extends Camera

export(Resource) var _dialogue = _dialogue as Dialogue

onready var player_cam = get_parent().get_node("Player/Camera")
onready var player_script = get_parent().get_node("Player")
onready var cutscene = get_parent().get_node("Camera/AnimationPlayer")
onready var dialogUI = get_parent().get_node("CanvasLayer/DialogUI")
onready var pintu_km = get_parent().get_node("PintuKamarMandi")

onready var movement = get_parent().get_node("Player/CharacterMover")


onready var raycast = get_parent().get_node("Player/Camera/RayCast")
onready var lemari =  get_parent().get_node("Lemari")

func switch():
	self.set_current(true)
	player_cam.clear_current(true)
	dialogUI.visible = false
	player_script.set_process(false)
	player_script.can_move = false
	
	movement.set_physics_process(false)
	
		
func switch_back():
	self.clear_current(true)
	player_cam.set_current(true)
	
	player_script.set_process(true)
	player_script.rotation.y = 0
	player_script.translation = Vector3(-23.289,0.867,2.718)
	player_script.visible = true
	player_script.can_move = true
	raycast.set_enabled(true)
	
	dialogUI.visible = true
	
	movement.set_physics_process(true)
	
	
	activate_lemari()
	emit_ui()
	

func emit_ui():
	GameEvents.emit_signal("dialog_initiated", _dialogue)
	

func activate_lemari():
	lemari.set_monitoring(true)
	lemari.set_monitorable(true)

func _on_PintuKamarMandi_area_entered(area):
	if area.name == "PickupArea":
		cutscene.play("cutscene_test")
		player_script.visible = false
		pintu_km.queue_free()

