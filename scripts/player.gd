extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var weapons: Node2D = $weapons



const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var climbing := false

var has_double_jump = true
const MAX_JUMPS = 2
var jump_num = 0
var can_double_jump = false
var jumps_left = MAX_JUMPS

func set_double_jump(set_value: bool):
	has_double_jump = set_value
	print("double jump = ", has_double_jump)

func set_climbing(set_value: bool):
	climbing = set_value

func manage_orientation_movement(direction: float, delta: float) -> void:
	handle_horizontal_movement(direction)
	handle_sprite_orientation()
	handle_gravity(delta)
	handle_jump()
	handle_climbing()

func handle_horizontal_movement(direction: float) -> void:
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func handle_sprite_orientation() -> void:
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
		weapons.scale.x = -1
	elif velocity.x > 0:
		animated_sprite_2d.flip_h = false
		weapons.scale.x = 1

func handle_gravity(delta: float) -> void:
	if not is_on_floor() and not climbing:
		velocity += get_gravity() * delta

#func handle_jump() -> void:
	#if Input.is_action_just_pressed("jump"):
		#if is_on_floor():
			#velocity.y = JUMP_VELOCITY
			#jump_num = 1
		#elif jump_num == 1:
			#velocity.y += JUMP_VELOCITY
			#jump_num += 1
			#can_double_jump = false
#
	#if is_on_floor():
		#jump_num = 0
		#can_double_jump = true
		
func handle_jump() -> void:
	if is_on_floor():
		if has_double_jump:
			jumps_left = 2
		else:
			jumps_left = 1

	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1


func handle_climbing() -> void:
	if climbing:
		if Input.is_action_pressed("move_up"):
			velocity.y = -SPEED
		elif Input.is_action_pressed("move_down"):
			velocity.y = SPEED
		else:
			velocity.y = 0

func handle_animation():
	if Input.is_action_just_pressed("attack_slash") and is_on_floor():
		weapons.play_active_weapon_animation("sword_slash_1")
		print("attack")
		
	if not is_on_floor():
		animated_sprite_2d.animation = "jump_animation"
	else:
		if velocity.x != 0:
			animated_sprite_2d.animation = "run"
		else:
			animated_sprite_2d.animation = "idle"
	

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	handle_animation()
	manage_orientation_movement(direction, delta)
	move_and_slide()
