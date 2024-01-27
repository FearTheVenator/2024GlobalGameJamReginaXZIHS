extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if(event.is_action_pressed("escape")): # quit game
		get_tree().quit()
	if(event.is_action_pressed("tilde")): # reload scene
		get_tree().reload_current_scene()
