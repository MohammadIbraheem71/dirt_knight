extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	print("play button was pressed")
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
