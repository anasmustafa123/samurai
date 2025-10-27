extends CharacterBody2D

@export var sprite : AnimatedSprite2D
@export var flipped_horizontal : bool
@export var gravity := 900.0
var is_in_teleport_area = false
var screen_size
var direction := Vector2.ZERO
var anim: AnimatedSprite2D
var current_teleport_area: Area2D = null

func _ready():
	screen_size = get_viewport_rect().size
	anim = $AnimatedSprite2D
	#scale.x = -1
func _physics_process(delta: float) -> void:
	if not is_on_floor(): 
		velocity.y += gravity * delta
	#var state_machine = get_node("/root/main/player/FSM")
	#print(state_machidne)
	#state_machine.play_fade_out()
	#if is_in_teleport_area:
		#if Input.is_action_just_pressed("interact"):
			#state_machine.state_transition.emit(self, "Teleport") 
	
	Turn()
	move_and_slide()


func Turn():
	var direction = -1 if flipped_horizontal == true else 1
	
	if(velocity.x < 0):
		sprite.scale.x = -direction
	elif(velocity.x > 0):
		sprite.scale.x = direction




func _on_teleport_area_body_entered(body: Node2D) -> void:
	print("player entering")
	is_in_teleport_area = true
	current_teleport_area = get_node("../TeleportArea")




func _on_teleport_area_body_exited(body: Node2D) -> void:
	print("player exiting")
	is_in_teleport_area = false
	current_teleport_area = null
