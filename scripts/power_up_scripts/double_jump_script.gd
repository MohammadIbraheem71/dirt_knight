extends PowerUp

class_name double_jump_power_up

func apply(player: Node) -> void:
	if player.has_method("set_double_jump"):
		player.set_double_jump(true)
	else:
		print("enable_double_jump method not found")
