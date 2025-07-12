extends Area2D

@export var height := 5
@export var tile_size := Vector2i(16, 16)
@export var tile_coords := Vector2i(0,0)
@export var atlas_source = 1
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


@onready var tile_map_layer: TileMapLayer = $TileMapLayer

@onready var climbable_bodies: Array[CharacterBody2D] = []

func _ready():
	generate_ladder()
	update_collision_shape()

func generate_ladder():
	

	tile_map_layer.clear()
	
	for i in range(height):
		tile_map_layer.set_cell(Vector2i(0, i), atlas_source, tile_coords)

func _on_body_entered(body):
	var shape := collision_shape_2d.shape
	print("body entered ladder size = ", shape.size)
	if body is CharacterBody2D and body.has_method("set_climbing"):
		body.set_climbing(true)
		climbable_bodies.append(body)

func _on_body_exited(body):
	print("body exited ladder")
	if body is CharacterBody2D and body.has_method("set_climbing"):
		body.set_climbing(false)
		climbable_bodies.erase(body)
		
func update_collision_shape():
	#collision_shape_2d.shape = collision_shape_2d.shape.duplicate()
	var shape = collision_shape_2d.shape
	shape.size = Vector2(tile_size.x, tile_size.y * height)
	print("ladder size = ", shape.size)
	collision_shape_2d.position = Vector2(tile_size.x / 2, (tile_size.y * height) / 2)
