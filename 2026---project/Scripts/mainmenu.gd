extends Control







func _on_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/home.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit()
