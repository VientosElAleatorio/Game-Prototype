extends State

func physics_update(delta):
	var dir = Input.get_axis("move_left", "move_right")

	var speed = player.walk_speed
	if Input.is_action_pressed("sprint"):
		speed = player.run_speed

	# Movimiento en aire
	if dir != 0:
		player.velocity.x = move_toward(
			player.velocity.x,
			dir * speed,
			speed * player.acceleration
		)

	# Slam
	if Input.is_action_just_pressed("ground_slam"):
		state_machine.change_state(get_parent().get_node("Slam"))

	# Aterrizaje
	if player.is_on_floor():
		player.jumps_left = player.TOTAL_JUMPS
		state_machine.change_state(get_parent().get_node("Idle"))
