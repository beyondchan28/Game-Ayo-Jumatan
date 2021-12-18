extends Spatial

export(Resource) var _dialogue = _dialogue as Dialogue
export(Resource) var _dialogue_sajadah = _dialogue_sajadah as Dialogue
export(Resource) var _dialogue_dompet = _dialogue_dompet as Dialogue

onready var pickup_area = get_parent().get_node("Player/PickupArea")
onready var player = get_parent().get_node("Player") 
onready var pintu_km = get_parent().get_node("PintuKamarMandi")

onready var toggler = get_parent().get_node("PickupAreaAndRaycastToggler")
onready var dompet_scene = get_parent().get_node("DompetScenario")
onready var sajadah = get_parent().get_node("Sajadah")


var curr_param = false
var activate = true
var activate_scene = true

func _process(delta):
	if curr_param == true:
		set_to_active()

func _on_DialogTrigger_body_entered(body):
	if body.name == "Player":
		if curr_param == false:
			activate_pintu_km(activate)
		else: 
			pass
		if player.items.empty():
			curr_param = true
			GameEvents.emit_signal("dialog_initiated", _dialogue)
			activate = false
		elif player.items[-1] == "Lemari":
			toggler.activate()
			GameEvents.emit_signal("dialog_initiated", _dialogue_sajadah)
			sajadah.activate()
		elif player.items[-1] == "Sajadah":
			GameEvents.emit_signal("dialog_initiated", _dialogue_dompet)
			if activate_scene == true:
				dompet_scene.activate(activate_scene)
			activate_scene = false 

 #dont touch anything

func activate_pintu_km(param):
	if param == true:
		pintu_km.set_monitoring(true)
		pintu_km.set_monitorable(true)
	else :
		pass

func set_to_active():
	pickup_area.set_monitoring(true)
	curr_param = false
