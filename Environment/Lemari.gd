extends Area

class_name Lemari

export(Resource) var _dialogue = _dialogue as Dialogue

onready var wudhu_trigger = get_parent().get_node("WudhuTrigger")
onready var toggler =  get_parent().get_node("PickupAreaAndRaycastToggler")

var can_activate

func _process(delta):
	if self.is_queued_for_deletion():
		toggler.deactivate()
		GameEvents.emit_signal("dialog_initiated", _dialogue)

func _ready():
	wudhu_trigger.set_monitoring(false)
	wudhu_trigger.set_monitorable(false)

func _on_Lemari_area_entered(area):
	if area.name == "PickupArea":
		wudhu_trigger.set_monitoring(true)
		wudhu_trigger.set_monitorable(true)
		

