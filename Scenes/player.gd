extends CharacterBody3D

@export var speed:= 6.0
var target_velocity = Vector3.ZERO

func _physics_process(delta: float) -> void:
	var direction 	= Vector3.ZERO
	
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("front"):
		direction.z -= 1
	if Input.is_action_pressed("back"):
		direction.z += 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		basis = Basis.looking_at(direction)
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	velocity = target_velocity
	
	move_and_slide()
