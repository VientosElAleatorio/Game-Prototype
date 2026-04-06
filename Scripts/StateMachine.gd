extends State
class_name StateMachine

var current_state: State

func change_state(new_state: State):
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func _input(event):
	if current_state:
		current_state.handle_input(event)
