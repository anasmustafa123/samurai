extends State

@export var animator : AnimationPlayer

func Enter():
	if(Input.is_action_just_pressed("interact")):
		pass
	animator.play("teleport_out")
	
