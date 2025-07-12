extends Node2D

const SPEED = 40

const TOTAL_HEALTH = 3

var health = TOTAL_HEALTH
var direction = 1; #1 for right, -1 for left


@onready var ray_cast_right: RayCast2D = $RayCast_right
@onready var ray_cast_left: RayCast2D = $RayCast_left
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("hello this is enemy")




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_death()
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
		
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
		
	position.x = position.x + (direction * SPEED * delta)

func _on_hurtbox_area_entered(area: Area2D) -> void:
	print("slime was hit")
	animated_sprite_2d.play("hit")
	await animated_sprite_2d.animation_finished
	print("playing default animation")
	dec_health()
	animated_sprite_2d.play("default")

func dec_health() -> void:
	health = health - 1
	
func check_death():
	if (health <= 0):
		enemy_death()
		
func enemy_death():
	print("died")
	direction = 0
	var smoke = preload("res://scenes/smoke_effect.tscn").instantiate()

	# Add to the same parent as the enemy
	get_parent().add_child(smoke)

	# Set position to match enemy's global position
	smoke.global_position = global_position

	smoke.play("smoke_poof")
	await smoke.animation_finished

	queue_free()
