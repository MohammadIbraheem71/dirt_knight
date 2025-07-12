extends Area2D

@export_enum("speed", "double_jump", "health") var effect_type: String

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var POWER_UPS = {
	"double_jump": preload("res://resources/power_ups/double_jump_power_up.tres")
}

var active_powerup: PowerUp

func _ready() -> void:
	if effect_type in POWER_UPS:
		active_powerup = POWER_UPS[effect_type]


		animated_sprite_2d.frames = active_powerup.sprite_frames
		animated_sprite_2d.play("rotate")
		animation_player.play("bob_up_and_down")
	else:
		push_error("Power-up type '%s' not found in POWER_UPS dictionary." % effect_type)

func _on_body_entered(body: Node2D) -> void:
	if active_powerup and body.name == "player":
		print("Player collected power-up: ", effect_type)
		active_powerup.apply(body)
		queue_free()
