extends ActionLeaf
@export var animator : AnimationPlayer

func tick(actor: Node, blackboard: Blackboard) -> int:
	animator.play("idle_normal")
	return RUNNING
