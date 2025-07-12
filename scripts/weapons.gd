extends Node2D

var weapons_list: Array = []
var active_weapon: Node = null

func _ready() -> void:
	# Automatically collect all weapon nodes (e.g. sword, bow, etc.)
	for child in get_children():
		weapons_list.append(child)
		print("added child = ", child.name)
	
	# Set the first weapon as active by default
	if weapons_list.size() > 0:
		active_weapon = weapons_list[0]

func set_active_weapon(index: int) -> void:
	if index >= 0 and index < weapons_list.size():
		active_weapon = weapons_list[index]
	else:
		print("Invalid weapon index!")

func play_active_weapon_animation(anim_name: String) -> void:
	if active_weapon:
		var anim_player = active_weapon.get_node_or_null("AnimationPlayer")
		if anim_player:
			anim_player.play(anim_name)
		else:
			print("animation player not found in weapon")
