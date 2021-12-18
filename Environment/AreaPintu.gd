extends Area

onready var anim = get_node("EngselPintu/AnimationPlayer")

var door = true

func _on_AreaPintu_body_entered(body):
	if body.name == "Player" and door:
		door = false
		var pintu_mesh = get_node("EngselPintu")
		pintu_mesh.rotation_degrees.y = 120
		anim.play("door_animation")
	elif body.name == "Player" and door == false:
		door = true


func _on_AreaPintu_body_exited(body):
	if body.name == "Player" and door == true:
		anim.play_backwards("door_animation")
		
