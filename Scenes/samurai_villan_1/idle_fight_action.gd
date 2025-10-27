extends ActionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	owner.animator.play("idle_normal")
	return SUCCESS
