extends State



func physics_update(delta):
	var dir = Input.get_axis("move_left", "move_right")

	if player.is_on_floor():
		player.jumps_left = player.TOTAL_JUMPS

	if dir != 0:
		state_machine.change_state(get_parent().get_node("Run"))

	if Input.is_action_just_pressed("jump"):
		state_machine.change_state(get_parent().get_node("Jump"))

	if not player.is_on_floor():
		state_machine.change_state(get_parent().get_node("Fall"))
