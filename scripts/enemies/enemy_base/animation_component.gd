extends Node

var is_locked:= false #if an animation is locked, it can NOT be interrupted
var playing := false #true if an animation is playing

@export var animated_sprite_path: NodePath
@export var animation_player_path: NodePath

var animated_sprite : AnimatedSprite2D
var animation_player : AnimationPlayer

signal locked_anim_finished_playing

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite = get_node_or_null(animated_sprite_path) as AnimatedSprite2D
	animation_player = get_node_or_null(animation_player_path) as AnimationPlayer

func play_animation(anim_name: String, lock: bool) -> void:
	#if some animation already has a lock , then we cant play 
	if is_locked:
		return
	
	if animated_sprite and animated_sprite.sprite_frames.has_animation(anim_name):
		animated_sprite.play(anim_name)
		playing = true
	elif animation_player and animation_player.has_animation(anim_name):
		animation_player.play(anim_name)
		playing = true
	
	if lock and playing:
		is_locked = true
		
		if animated_sprite and animated_sprite.is_playing():
			await animated_sprite.animation_finished
		if animation_player and animation_player.is_playing():
			await animation_player.animation_finished
		
		is_locked = false
		playing = false
		emit_signal("locked_anim_finished_playing")
	
