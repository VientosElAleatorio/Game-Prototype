extends CharacterBody2D

@export var walk_speed = 650.0
@export var run_speed = 1000.0
@export var acceleration = 0.1
@export var deceleration = 0.1
@export var jump_force = -400.0

const GROUND_SLAM_SPEED = 1200.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var jumps_left: int = 0
const TOTAL_JUMPS: int = 2
var is_slamming: bool = false

@onready var player_model: Node3D = $SubViewport/Node3D/low_poly_prot
@onready var camera_2d: Camera2D = $Camera2D
@onready var state_machine: StateMachine = $StateMachine

func _ready():
	for state in state_machine.get_children():
		if state is State:
			state.state_machine = state_machine
			state.player = self
	state_machine.change_state($StateMachine/Idle)
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()
