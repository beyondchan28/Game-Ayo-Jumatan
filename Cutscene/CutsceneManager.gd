extends Camera

onready var player_cam = get_parent().get_node("Player/Camera")
onready var player_script = get_parent().get_node("Player")
onready var cutscene = get_parent().get_node("Camera/AnimationPlayer")
onready var dialogUI = get_parent().get_node("CanvasLayer/DialogUI")

onready var pintu_km = get_parent().get_node("PintuKamarMandi")



func switch():
	self.set_current(true)
	player_cam.clear_current(true)
	dialogUI.visible = false
	player_script.set_process(false)

func switch_back():
	self.clear_current(true)
	player_cam.set_current(true)
	dialogUI.visible = true
	player_script.set_process(true)
	
	player_script.visible = true


func _on_PintuKamarMandi_body_entered(body):
	if body.name == "Player":
		cutscene.play("cutscene_test")
		player_script.rotation.y = 0
		player_script.translation = Vector3(-23.289,0.867,2.718)
		player_script.visible = false
		pintu_km.queue_free()
