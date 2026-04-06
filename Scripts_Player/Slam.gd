extends State

var landed := false
func enter():
	player.velocity.y = player.GROUND_SLAM_SPEED
	player.velocity.x = 0
	player.is_slamming = true
	landed = false

func physics_update(delta):
	if player.is_on_floor() and not landed:
		player.is_slamming = false
		player.camera_2d.screen_shake(10.0, 0.2)
		state_machine.change_state(get_parent().get_node("Idle"))
