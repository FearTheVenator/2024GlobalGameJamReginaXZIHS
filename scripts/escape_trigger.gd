extends Node3D



func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_escape_area_body_entered(body):
	if body.has_method("player"):
		get_tree().change_scene_to_file("res://scenes/ending.tscn")
