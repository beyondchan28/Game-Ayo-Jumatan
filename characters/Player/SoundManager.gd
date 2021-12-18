extends AudioStreamPlayer

export(AudioStreamSample) var walk_sound

onready var player = get_parent().get_node("CharacterMover")

#still doesnt work and move_vec value its just doesnt make sense
func _physics_process(delta):
	if player.move_vec == Vector3.ZERO:
		self.play()
	else:
		self.stop()

func play_set_sound(audio):
	self.set_stream(audio)
