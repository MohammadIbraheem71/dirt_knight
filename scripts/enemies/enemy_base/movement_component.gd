extends Node

@export var speed: float = 40.0
@export var gravity: float = 400.0
@export var character_path: NodePath  # Drag and drop in editor

var direction := 1
var character: CharacterBody2D
var disabled:= false

func _ready() -> void:
	character = get_node(character_path) as CharacterBody2D

func move(delta: float) -> void:
	if not character or disabled:
		return

	character.velocity.y += gravity * delta
	character.velocity.x = direction * speed
	character.move_and_slide()

	if character.is_on_wall():
		direction *= -1
		var sprite := character.get_node_or_null("AnimatedSprite2D")
		if sprite:
			sprite.flip_h = direction == -1
	
