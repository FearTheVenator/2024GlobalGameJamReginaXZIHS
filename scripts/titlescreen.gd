extends Button





func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")



func _on_options_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
