extends Camera3D

@export var target: Node3D
@export var follow_speed: float = 5.0

var offset: Vector3

func _ready() -> void:
	if target:
		# Store the initial offset between camera and player
		offset = global_transform.origin - target.global_transform.origin

func _process(delta: float) -> void:
	if not target:
		return
	
	# Desired position is always player's position + the fixed offset
	var desired_position = target.global_transform.origin + offset
	
	# Smoothly interpolate camera toward desired position
	global_transform.origin = global_transform.origin.lerp(desired_position, follow_speed * delta)
	
	# Keep rotation fixed (don’t use look_at)
	
