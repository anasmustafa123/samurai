extends State
class_name PlayerIdle

@export var animator : AnimationPlayer
var attack_actions = ["sword_attack_1", "sword_attack_2", "sword_attack_3"]


func Enter():
	animator.play("idle")


func Update(_delta : float):
	if(Input.get_vector("left", "right", "up", "down").normalized()):
		state_transition.emit(self, "Walk")
	
	if Input.is_action_just_pressed("interact") and owner.is_in_teleport_area:
		state_transition.emit(self, "TeleportOut")
	
	for attack_action in attack_actions:
		if Input.is_action_just_pressed(attack_action):
			state_transition.emit(self, "Attacking")
			break
	
