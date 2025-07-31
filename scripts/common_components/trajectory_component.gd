extends Node

@export var GRAVITY := 9.81
@export var character_path: NodePath  # Drag and drop in editor

var character: CharacterBody2D

func set_gravity(gravity: float) ->void:
	GRAVITY = gravity

func _ready():
	character = get_node_or_null(character_path) as CharacterBody2D

func calculate_trajectory(init_velocity: float, relative_pos: Vector2i)-> float:
	var vel_square = pow(init_velocity, 2)
	var x_square = pow(relative_pos.x, 2)
	
	var square_term = (pow(vel_square, 2)) - GRAVITY * (GRAVITY * (x_square) + 2 * (relative_pos.y * (vel_square)))
	
	if square_term < 0:
		print("out of range")
		return 0.0
	
	var square_root = sqrt(square_term)
	
	var tan_theta = (vel_square + square_root) / ( GRAVITY * relative_pos.x)
	
	var final_theta = atan(tan_theta)
	print("final theta = ", final_theta)
	return final_theta
	
func launch(init_velocity: float, relative_pos: Vector2i) ->void:
	var theta = calculate_trajectory(init_velocity, relative_pos)
	print("theta = ", theta)
	var init_velocity_components = Vector2(init_velocity * cos(theta), -1*  init_velocity * sin (theta))
	
	character.velocity = init_velocity_components
