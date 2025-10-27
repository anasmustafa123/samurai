extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	owner.animator.play("jap")
	return SUCCESS
