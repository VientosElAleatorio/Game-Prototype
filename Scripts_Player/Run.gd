extends State

func physics_update(delta):
	var dir = Input.get_axis("move_left", "move_right")

	var speed = player.walk_speed
	if Input.is_action_pressed("sprint"):
		speed = player.run_speed

	if dir != 0:
		player.velocity.x = move_toward(player.velocity.x, dir * speed, speed * player.acceleration)

		# Rotación modelo
		if dir > 0:
			player.player_model.rotation.y = PI/3
		else:
			player.player_model.rotation.y = -PI/3
	else:
		state_machine.change_state(get_parent().get_node("Idle"))
	

	# Salto
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state(get_parent().get_node("Jump"))

	# Caída
	if not player.is_on_floor():
		state_machine.change_state(get_parent().get_node("Fall"))
