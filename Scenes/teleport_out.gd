extends State
@export var fade_duration := 1.0  # seconds

@export var animator : AnimationPlayer

func Enter():
	animator.play("teleport_out")
	await animator.animation_finished
	await get_tree().create_timer(fade_duration).timeout
	
	if owner.current_teleport_area and owner.current_teleport_area.target_area_path:
		var target_area = owner.current_teleport_area.get_node(owner.current_teleport_area.target_area_path)
		if target_area:
			owner.visible = false
			print(target_area.global_position)
			owner.global_position = target_area.global_position
			await get_tree().process_frame  # let camera & physics update
			owner.visible = true
		#var target_pos = target_area.global_position
		#owner.global_position = target_pos

	animator.play("teleport_in")
	
	await get_tree().create_timer(fade_duration).timeout
	state_transition.emit(self, "Idle")
	#animator.play("teleport_in")
