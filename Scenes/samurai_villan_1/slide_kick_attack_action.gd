extends ActionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	owner.animator.play("slide_kick")
	return SUCCESS
