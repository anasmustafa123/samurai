extends CharacterBody2D

@export var speed := 150.0

var direction := Vector2.ZERO
var anim: AnimatedSprite2D

func _ready() -> void:
	anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Movement input
	direction = Input.get_vector("left", "right", "up", "down")
	
	# Apply velocity
	velocity = direction * speed
	move_and_slide()

	# Handle animations
	if direction == Vector2.ZERO:
		anim.play("idle")
	else:
		anim.play("walk")

		# Flip horizontally if moving left
		if direction.x < 0:
			anim.flip_h = true
		elif direction.x > 0:
			anim.flip_h = false
