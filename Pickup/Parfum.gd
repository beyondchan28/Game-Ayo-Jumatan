extends Area

class_name Parfum

onready var parfum_mesh = $Parfume

func _on_Parfum_area_entered(area):
	if area.name == "PickupArea":
		pass

func _on_Parfum_visibility_changed():
	pass
