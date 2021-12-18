extends KinematicBody

export var mouse_sens = 0.5

onready var camera = $Camera
onready var character_mover = $CharacterMover
onready var pick_up_area = $PickupArea
onready var animation = $Graphics/AnimationPlayer
onready var raycast = $Camera/RayCast
onready var default_costume = $Graphics/Armature/Skeleton/Default
onready var change_costume = $Graphics/Armature/Skeleton/Costume


onready var wall = get_parent().get_node("House/Tembok")
onready var pickup_noticer = get_parent().get_node("CanvasLayer/PickupNoticer")
onready var anim = get_parent().get_node("CanvasLayer/AnimationPlayer")

var items = []
var can_move = true

onready var parfume_on_hand = $Graphics/Armature/Skeleton/BoneAttachment2/Parfume

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	character_mover.init(self)

func _process(delta):
	if pick_up_area.is_monitoring():
		collecting_item()
	if can_move == true :
		movement_input()
	noticer()
	
	for item in items:
		if item == "Sajadah":
			$Graphics/Armature/Skeleton/BoneAttachment/Sajadah_Equip.visible = true

func movement_input():
	var move_vec = Vector3()
	
	if Input.is_action_pressed("move_forward"):
		move_vec += Vector3.FORWARD
	if Input.is_action_pressed("move_backward"):
		move_vec += Vector3.BACK
	if Input.is_action_pressed("move_left"):
		move_vec += Vector3.LEFT
	if Input.is_action_pressed("move_right"):
		move_vec += Vector3.RIGHT
	character_mover.set_move_vec(move_vec)
	set_anim(move_vec, can_move)
	
#	if Input.is_action_just_pressed("jump"):
#		character_mover.jump()
	

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= mouse_sens * event.relative.x
		camera.rotation_degrees.x -= mouse_sens * event.relative.y
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 70)



func set_anim(move_vec : Vector3, can_move:bool):
	if can_move == true :
		if move_vec == Vector3.ZERO:
			animation.play("Idle_Loop", 0.1)
		elif move_vec == Vector3.FORWARD or move_vec == Vector3(1,0,-1) or move_vec == Vector3(-1,0,-1) :
			animation.play("WalkForward_Loop", 0.1)
		elif move_vec == Vector3.BACK or move_vec == Vector3(1,0,1) or move_vec == Vector3(-1,0,1):
			animation.play_backwards("WalkForward_Loop", 0.1)
		elif move_vec == Vector3.LEFT:
			animation.play("WalkLeft_Loop",0.1)
		elif move_vec == Vector3.RIGHT:
			animation.play("WalkRight_Loop",0.1)

func _on_AnimationPlayer_animation_finished(anim_name):
	#get_tree().change_scene("res://Scenes/Scene2.tscn")
	if anim_name == "Parfum":
		can_move = true

func collecting_item():
	var item = pick_up_area.get_overlapping_areas()
	for object in item:
		if Input.is_action_just_pressed("collect"):
			if object is Lemari:
				default_costume.visible = false
				change_costume.visible = true
				items.append(object.name)
				object.queue_free()
			elif object is Item :
				items.append(object.name)
				object.queue_free()
			elif object is Parfum:
				object.visible = false
				parfume_on_hand.visible = true
				animation.stop()
				can_move = false
				animation.play("Parfum")
				yield(animation, "animation_finished")
				object.visible = true
				parfume_on_hand.visible = false
				
				


func noticer():
	var object:Area = raycast.get_collider()
	if object is Item:
		pickup_noticer.visible = true
		pickup_noticer.text = object.name
	elif object is Lemari:
		pickup_noticer.visible = true
		pickup_noticer.text = "Ganti Baju"
	elif object is Pintu:
		pickup_noticer.visible = true
		pickup_noticer.text = "Tekan Enter untuk pergi"
		if Input.is_action_just_pressed("ui_accept"):
			anim.play("transition")
	elif object is Parfum:
		pickup_noticer.visible = true
		pickup_noticer.text = "Parfum"
	else :
		pickup_noticer.visible = false




