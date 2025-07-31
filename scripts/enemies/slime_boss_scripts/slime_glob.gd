extends CharacterBody2D

@onready var trajectory_component: Node = $trajectory_component

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var glob_velocity: float
var target_pos: Vector2i

func set_target(in_target: Vector2i):
	target_pos = in_target

func set_glob_velocity(in_velocity: float) -> void:
	glob_velocity = in_velocity

func _ready() -> void:
	print("slime glob constructor called")
	print("gravity = ", get_gravity())
	trajectory_component.set_gravity(ProjectSettings.get_setting("physics/2d/default_gravity"))
	
func glob_launch() -> void:
	trajectory_component.launch(glob_velocity, target_pos)
	print("glob_launch")

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		#print("gravity = ", get_gravity())

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	move_and_slide()
