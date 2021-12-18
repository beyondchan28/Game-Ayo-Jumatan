extends Area

signal got_pickup

var inventory = []


func _ready():
	connect("area_entered", self, "on_area_enter")

func on_area_enter(pickup: Pickup):
	inventory.append(pickup.pickup_type)
	emit_signal("got_pickup", pickup.pickup_type)
	pickup.queue_free()
