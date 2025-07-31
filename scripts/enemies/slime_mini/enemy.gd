extends CharacterBody2D

@onready var movement_component: Node = $movement_component
@onready var health_component: Node = $health_component
@onready var enemy_hurtbox: Area2D = $enemy_hurtbox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_component: Node = $animation_component

var is_hit_anim_playing:= false

const lock := true
const dont_lock := false

func _ready() -> void:
	print("enemy spawning")
	animation_component.play_animation("default", dont_lock)

func _physics_process(delta: float) -> void:
	movement_component.move(delta)
	


func _on_enemy_hurtbox_hit() -> void:
	print("hit detected")
	health_component.dec_health()
	animation_component.play_animation("hit", lock)

func _on_health_component_died() -> void:
	movement_component.disabled = true
	var smoke_scene = preload("res://scenes/smoke_effect.tscn")
	var smoke = smoke_scene.instantiate()
	
	get_parent().add_child(smoke)
	smoke.global_position = global_position
	
	if smoke.has_method("play"):
		smoke.play("smoke_poof")
		await smoke.animation_finished
	
	queue_free()
