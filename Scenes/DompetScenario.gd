extends Area

export(Resource) var _dialogue = _dialogue as Dialogue

onready var dompet = get_parent().get_node("Dompet")

var activate

func _on_DompetScenario_area_entered(area):
	if area.name == "PickupArea":
		dompet.activate()
		GameEvents.emit_signal("dialog_initiated", _dialogue)
		self.queue_free()

func activate(param):
	if param == true :
		self.set_monitoring(true)
		self.set_monitorable(false)
	else:
		pass
