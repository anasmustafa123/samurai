extends CharacterBody3D

@export var speed := 6.0
var target_velocity = Vector3.ZERO

@onready var anim = $AnimatedSprite3D

enum State { IDLE, WALK, ATTACK, DEATH }
var state: State = State.IDLE


func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO

	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("front"):
		direction.z -= 1
	if Input.is_action_pressed("back"):
		direction.z += 1
	
	# --- Flip sprite left/right ---
	if direction.x < 0:
		anim.flip_h = true    # face left
	elif direction.x > 0:
		anim.flip_h = false   # face right
			
	# apply velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	velocity = target_velocity
	move_and_slide()


 
	if direction != Vector3.ZERO:
		change_state(State.WALK)
	else:
		change_state(State.IDLE)


func change_state(new_state: State):
	if state == new_state:
		return
	state = new_state

	match state:
		State.IDLE:
			anim.play("idle")
		State.WALK:
			anim.play("walk")
		State.ATTACK:
			anim.play("attack")
		State.DEATH:
			anim.play("death")


# --------------------
# Signals
# --------------------
func _on_AnimatedSprite3D_animation_finished():
	if anim.animation == "attack":
		change_state(State.IDLE)
