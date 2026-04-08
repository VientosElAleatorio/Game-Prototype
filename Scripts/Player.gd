extends CharacterBody2D

var a = 20

# Velocidades iniciales
@export var walk_speed = 650.0
@export var run_speed = 1500.0
@export_range(0, 1) var acceleration = 0.1
@export_range(0, 1) var deceleration = 0.1

# Modelo 3D
@onready var player: Node3D = $SubViewport/Node3D/low_poly_prot
# Camera_shake
@onready var camera_2d: Camera2D = $Camera2D
# Salto
@export var jump_force = -400.0

#Ground slam
const GROUND_SLAM_SPEED = 1200.0
var is_slamming := false
# Gravedad
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Doble salto
var jumps_left: int = 0
const TOTAL_JUMPS: int = 2
var was_in_air: bool = false


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	
	if was_in_air and is_on_floor():
		was_in_air = false
	if Input.is_action_just_pressed("ground_slam") and not is_on_floor():
		is_slamming = true
		velocity.y = GROUND_SLAM_SPEED
		velocity.x = 0
	
	if is_on_floor() and is_slamming:
		is_slamming = false
		camera_2d.screen_shake(10.0, 0.2)
	
	if is_on_floor():
		jumps_left = TOTAL_JUMPS
		is_slamming = false
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_force
			jumps_left = TOTAL_JUMPS - 1
		else:
			if jumps_left > 0:
				velocity.y = jump_force
				jumps_left -= 1
				
				if jumps_left == 0:
					velocity.y = jump_force
	
	
	
	var speed
	if Input.is_action_pressed("sprint"):
		speed = run_speed
	else:
		speed = walk_speed

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction :float = Input.get_axis("move_left", "move_right")
	
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
		if direction > 0:
			player.rotation.y = PI/3
		else:
			player.rotation.y = -PI/3
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed * deceleration)



	move_and_slide()
