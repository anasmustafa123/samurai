extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	print("is_player_in_agro_range", owner.is_player_in_agro_range)
	if owner.is_player_in_agro_range:
		return SUCCESS
	else:
		return FAILURE
