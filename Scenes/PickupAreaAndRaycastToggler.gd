extends Spatial

onready var pickup_area = get_parent().get_node("Player/PickupArea")
onready var raycast = get_parent().get_node("Player/Camera/RayCast")
onready var player = get_parent().get_node("Player")
onready var movement = get_parent().get_node("Player/CharacterMover")

func player_process(param:bool):
	player.set_process(param)
	player.can_move = param
	movement.set_physics_process(param)

func player_active():
	player.rotation.y = 0
	player.translation = Vector3(-23.289,0.867,2.718)
	

func activate():
	pickup_area.set_monitoring(true)
	raycast.set_enabled(true)
	
func deactivate():
	pickup_area.set_monitoring(false)
	raycast.set_enabled(false)
