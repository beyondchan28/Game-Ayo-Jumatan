extends Spatial

signal dead
signal hurt
signal healed
signal health_changed
signal gibbed

export var max_health = 100
var cur_heatlh = max_health

export var gib_at = -10

func _ready():
	init()

func init():
	cur_heatlh = max_health
	emit_signal("health_changed", cur_heatlh)

func hurt(damage: int, dir: Vector3):
	if cur_heatlh <= 0:
		return
	cur_heatlh -= damage
	if cur_heatlh <= gib_at:
		pass
		emit_signal("gibbed")
	if cur_heatlh <= 0:
		emit_signal("dead")
	else :
		emit_signal("hurt")
	emit_signal("health_changed", cur_heatlh)

func heal(amount: int):
	if cur_heatlh <= 0:
		return
	cur_heatlh += amount
	if cur_heatlh > max_health:
		cur_heatlh = max_health
	emit_signal("healed")
	emit_signal("health_changed", cur_heatlh)
