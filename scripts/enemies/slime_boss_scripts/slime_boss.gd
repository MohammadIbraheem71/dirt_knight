extends CharacterBody2D

@onready var animation_component: Node = $animation_component
@onready var health_component: Node = $health_component
@onready var movement_component: Node = $movement_component
@onready var timer: Timer = $Timer


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const lock := true
const dont_lock := false

func _ready() -> void:
	print("called once")
	timer.start(5)
	animation_component.play_animation("default", dont_lock )
	
func _physics_process(delta: float) -> void:
	#movement_component.move(delta)
	move_and_slide()

#spawns a glob whenever called
func spawn_glob() -> void:
	var glob_scene = preload("res://scenes/enemies/slime_boss_scenes/slime_glob.tscn")
	var glob = glob_scene.instantiate()
	add_child(glob)
	#for child in glob.get_children():
		#print(child)
	
	#await glob.ready
	glob.set_target(Vector2i(0, 120))
	glob.set_glob_velocity(300)
	glob.global_position = global_position
	
	glob.glob_launch()
	
func _on_enemy_hurtbox_hit() -> void:
	animation_component.play_animation("hurt", lock)
	health_component.dec_health()

func _on_health_component_died() -> void:
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	print("timed out")
	if (animation_component.is_locked):
		await animation_component.locked_anim_finished_playing
	animation_component.play_animation("launch_glob", lock)
	spawn_glob()
	
	await animation_component.locked_anim_finished_playing
	animation_component.play_animation("default", dont_lock)
