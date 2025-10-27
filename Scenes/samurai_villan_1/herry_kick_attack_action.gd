extends ActionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	owner.animator.play("herry_kick")
	return SUCCESS
