extends State
class_name PlayerRun

@export var animator : AnimationPlayer


func Enter():
	animator.play("run")
