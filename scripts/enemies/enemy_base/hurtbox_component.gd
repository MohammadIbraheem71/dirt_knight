
extends Area2D

signal hit  # emits when hurtbox is entered

func _ready():
	pass

func _on_area_entered(area):
	if area.name == "sword":  # you can use groups or other checks too
		emit_signal("hit")
