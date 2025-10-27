extends RigidBody2D

@onready var beehave_tree = $BeehaveTree
var is_player_in_agro_range = false
var attacking_player : CharacterBody2D
@export var animator : AnimationPlayer
@export var base_point : Vector2

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.flip_h = true

func Turn():
	if linear_velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	elif linear_velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
			
func take_damage(damage: int):
	print("taking", damage, "damage")
	pass

func distance_to_base(player):
	if player:
		var to_player = player.global_position - global_position
		var distance = to_player.length()
	else:
		var to_player = player.global_position - global_position
		var distance = to_player.length()
		pass
	var to_mob_home_point = player.global_position - base_point
	var to_mob_home_point_dist = to_mob_home_point.length()
	return to_mob_home_point_dist
	
