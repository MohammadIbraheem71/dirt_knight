# PowerUp.gd
extends Resource
class_name PowerUp

@export var name: String
@export var sprite_frames: SpriteFrames
@export var description: String

func apply(player: Node) -> void:
	pass  # to be overridden by inherited classes
