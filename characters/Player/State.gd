extends Spatial

enum STATES {IDLE, WALK, INTERACT, COLLECT}

var cur_state = STATES.IDLE

onready var character_mover = $CharacterMover

func _ready():
	set_state_idle()
	character_mover.init(self)

func _process(delta):
	match cur_state :
		STATES.IDLE:
			pass
		STATES.WALK:
			pass
		STATES.INTERACT:
			pass
		STATES.COLLECT:
			pass

func set_state_idle():
	cur_state = STATES.IDLE
	#play animation node idle

func set_state_walk():
	cur_state = STATES.WALK

func set_state_interact():
	cur_state = STATES.INTERACT

func set_state_collect():
	cur_state = STATES.COLLECT
