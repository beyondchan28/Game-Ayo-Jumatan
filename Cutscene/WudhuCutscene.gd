extends Area

onready var toggler = get_parent().get_node("PickupAreaAndRaycastToggler")
onready var wudhu_cutscene = get_parent().get_node("WudhuTrigger/WudhuCutscene")

var active = false

func _ready():
	wudhu_cutscene.visible = false
	wudhu_cutscene.set_process(false)

func _on_WudhuTrigger_area_entered(area):
	toggler.player_process(active)
	if area.name == "PickupArea":
		wudhu_cutscene.visible = true
		wudhu_cutscene.play()


func _on_WudhuCutscene_finished():
	toggler.player_active()
	active = true
	toggler.player_process(active)
	wudhu_cutscene.stop()
	wudhu_cutscene.queue_free()
	self.queue_free()



