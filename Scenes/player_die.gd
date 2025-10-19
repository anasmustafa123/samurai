extends State
class_name PlayerDie

@export var animator : AnimationPlayer

func Enter():
	animator.play("die")
	
	
