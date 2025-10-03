extends CharacterBody2D

@export var speed := 150.0
var screen_size
var direction := Vector2.ZERO
var anim: AnimatedSprite2D
var next_animation = true
var input_locked := false   # <-- lock input during attacks
#@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@export var combo_time := 0.4 # seconds allowed between presses
#var combo_count := 0
#var combo_timer := 0.0

var attack_actions = [
	'sword_attack_1',
	'sword_attack_2',
	'sword_attack_3',
]
var current_attack = ""

func _ready():
	screen_size = get_viewport_rect().size
	anim = $AnimatedSprite2D
	anim.animation_finished.connect(_on_animation_finished)
	
var is_attacking = false
var attack_queue: Array[String] = []


func _physics_process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	var move_direction = Input.get_axis('left', 'right')

	# movement still works if not attacking
	if not input_locked:
		if Input.is_action_pressed("right"):
			velocity.x += 1
			anim.flip_h = 0
		elif Input.is_action_pressed("left"):
			velocity.x -= 1
			anim.flip_h = 1
		velocity = velocity.normalized() * speed

	# update combo timer
	#combo_timer -= delta
	#if combo_timer <= 0:
		#combo_count = 0  

	# check attack input ANYTIME, even during animation (buffering)
	for attack_action in attack_actions:
		if Input.is_action_just_pressed(attack_action):
			# valid combo step?
			#if (attack_action == attack_actions[0] and combo_count == 0) \
			#or (attack_action == attack_actions[1] and combo_count == 1):
				#combo_count += 1
				#combo_timer = combo_time

			# push into queue regardless if animation still running
			_append_attack_queue(attack_action)
			# if we are free to act, start immediately
			if not is_attacking:
				_play_next_attack()
			break

	# idle/walk if not attacking
	if move_direction:
		if not is_attacking:
			anim.play('walk')
	else:
		if not is_attacking:
			anim.play('idle')
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _do_attack(anim_name: String) -> void:
	#if attack_queue.size() == 0:
	input_locked = true
	#print(input_locked)
	current_attack = anim_name
	anim.play(anim_name)
	is_attacking = true


func _on_animation_finished():
	if is_attacking and anim.animation == current_attack:
		input_locked = false
		is_attacking = false
		current_attack = ""
		
		# ✅ Now play next attack in the queue
		if attack_queue.size() > 0:
			_play_next_attack()

func _append_attack_queue(attack_action: String):
	if attack_queue.size() < 3:
		attack_queue.push_back(attack_action)


func _play_next_attack():
	print(attack_queue)
	if attack_queue.size() > 0:
		var next_attack = attack_queue.pop_front()
		_do_attack(next_attack)
