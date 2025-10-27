class_name IsPlayerVisible
extends ConditionLeaf

@export var player_detection_range: float = 500.0
@export var vision_cone_angle: float = 45.0  # degrees

func tick(actor: Node, blackboard: Blackboard) -> int:
	# Get player reference (could be cached in blackboard)
	var player = get_tree().get_first_node_in_group("Player")
	if not player:
		return FAILURE
	
	# Calculate distance and direction to player
	var to_player = player.global_position - actor.global_position
	var distance = to_player.length()
	
	#var mob_home_point = actor.base_point
	#var to_mob_home_point = player.global_position - mob_home_point
	#var to_mob_home_point_dist = to_mob_home_point.length()
	var to_mob_home_point_dist = 2000
	if actor.has_method("distance_to_base"):
		to_mob_home_point_dist = actor.distance_to_base(player)
	else:
		return FAILURE
	#print(to_mob_home_point_dist)a
	# Check if player is within detection range 
	if distance > player_detection_range or to_mob_home_point_dist > 900:
		return FAILURE
	
	# Check if player is within vision cone
	var forward_dir = Vector2.RIGHT.rotated(actor.rotation)
	var angle_to_player = forward_dir.angle_to(to_player.normalized())
	if abs(angle_to_player) > deg_to_rad(vision_cone_angle):
		return FAILURE
	#print(player.global_position)
	# Player is visible, save position in blackboard
	blackboard.set_value("player_position", player.global_position)
	blackboard.set_value("player_detected", true)
	blackboard.set_value("small_attack_range", 100.0)
	blackboard.set_value("large_attack_range", 300.0)

	return SUCCESS
