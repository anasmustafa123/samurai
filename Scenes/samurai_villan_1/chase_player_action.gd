class_name ChasePlayer
extends ActionLeaf
#
@export var move_speed: float = 300.0

func tick(actor: Node, blackboard: Blackboard) -> int:
	# Get the player position from the blackboard
	var player_pos = blackboard.get_value("player_position")
	if not player_pos:
		return FAILURE
	
	# Calculate direction to player
	var direction = (player_pos - actor.global_position).normalized()
	
	# Move toward player)
	actor.angular_velocity = 0
	actor.lock_rotation = true
	actor.linear_velocity = direction * move_speed
	# Store attack range in blackboard
	var small_attack_range = blackboard.get_value("small_attack_range")
	var large_attack_range = blackboard.get_value("large_attack_range")
	
	# Check if within attack range
	var distance = actor.global_position.distance_to(player_pos)
	#print(distance)
	var attack_range = 0.0
	if distance > 100.0 and distance <= 300.0:
		attack_range = large_attack_range
	else:
		attack_range = small_attack_range	
	print(distance)
	print("attack_range", attack_range)
	if distance <= attack_range:
		return SUCCESS
	if actor.has_node("AnimationPlayer"):
		#print("has animation player")
		actor.get_node("AnimationPlayer").play("run")
	# Still chasing
	return RUNNING
