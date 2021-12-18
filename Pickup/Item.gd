extends Area
class_name Item

export(Resource) var _dialogue_sajadah = _dialogue_sajadah as Dialogue
export(Resource) var _dialogue_dompet = _dialogue_dompet as Dialogue

onready var dompet = get_parent().get_node("Dompet")
onready var sajadah = get_parent().get_node("Sajadah")


func _on_Sajadah_body_exited(body):
	if body.name == "Player":
		if sajadah.is_queued_for_deletion():
			GameEvents.emit_signal("dialog_initiated", _dialogue_sajadah)

func _on_Dompet_area_exited(area):
	print (area.name)
	if area.name == "PickupArea":
		if dompet.is_queued_for_deletion():
			print(dompet.is_queued_for_deletion())
			GameEvents.emit_signal("dialog_initiated", _dialogue_dompet)


func activate():
	self.set_monitorable(true)
	self.set_monitoring(true)

func deactivate():
	self.set_monitorable(false)
	self.set_monitoring(false)





