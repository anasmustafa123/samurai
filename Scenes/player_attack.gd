extends State
class_name PlayerAttacking

@export var animator : AnimationPlayer
var current_attack : Attack_Data
@export var attacks : Array[Attack_Data]
#@onready var hit_particles = $"../../AnimatedSprite2D/HitParticles"

func _ready():
	print("player attack ready")
	# Connect animation signals
	if not animator.is_connected("animation_started", Callable(self, "_on_animation_started")):
		animator.connect("animation_started", Callable(self, "_on_animation_started"))
	if not animator.is_connected("animation_finished", Callable(self, "_on_animation_finished")):
		animator.connect("animation_finished", Callable(self, "_on_animation_finished"))

func Enter():
	#AudioManager.play_sound(AudioManager.PLAYER_ATTACK_SWING, 0.3, 1)
	
	#Play the attack animation and wait for it to finish, transition from this state is handled by the animation player
	DetermineAttack()
	animator.play(current_attack.anim)
	await animator.animation_finished
	state_transition.emit(self, "idle")

#Read which attack to use from our two attack nodes
func DetermineAttack():
	if(Input.is_action_just_pressed("sword_attack_1")):
		current_attack = attacks[0]
	elif(Input.is_action_just_pressed("sword_attack_2")):
		current_attack = attacks[1]
	elif(Input.is_action_just_pressed("sword_attack_3")):
		current_attack = attacks[2]


# Called when animation emits an event (key in animation editor)
func _on_animation_started(anim_name: String, event_name: String, _position: float):
	print("event_name", event_name)
	if event_name == "hit_frame":
		hit_frame()

# Called when attack animation finishes
func _on_animation_finished(anim_name: String):
	if current_attack and anim_name == current_attack.anim:
		# Go back to idle or any other state
		state_transition.emit(self, "Idle")


#Called exactly when the attack connects
func hit_frame():
	print("Hit frame triggered for:", current_attack.anim)
	
	# Wait one physics frame for overlaps to update
	await get_tree().process_frame
	
	
	# Example: damage nearby enemies
	if owner.has_node("HitBox"):
		var hitbox = owner.get_node("HitBox")
		print(hitbox.has_overlapping_areas())
		print(hitbox.has_overlapping_bodies())
		for body in hitbox.get_overlapping_bodies():
			if body.is_in_group("enemies"):
				if body.has_method("take_damage"):
					body.take_damage(current_attack.damage)
					print("Dealt", current_attack.damage, "damage to", body.name)


#Hitbox is turned on/off through the animationplayer, it an enemy is standing inside of it once that happens they take damage
#Both hitboxes call back to this function through signals
#func _on_hitbox_body_entered(body):
	#if body.is_in_group("Enemy"):
		#deal_damage(body)
		#AudioManager.play_sound(AudioManager.PLAYER_ATTACK_HIT, 0, 1)

#func deal_damage(enemy : EnemyMain):
	#hit_particles.emitting = true
	#enemy._take_damage(current_attack.damage)
