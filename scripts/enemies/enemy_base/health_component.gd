extends Node

signal died

@export var total_health: int = 3
var health: int

func _ready() -> void:
	health = total_health

func dec_health() -> void:
	health -= 1
	if health <= 0:
		emit_signal("died")
