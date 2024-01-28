extends Node

signal pressed_esc
var player
var startTime

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player = $Main3D/Player/CharacterBody3D
	$Citynoise.play(randf_range(0,200))
	startTime = Time.get_ticks_msec()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MainGUI/Timer.text = str((Time.get_ticks_msec() - startTime) / 10)

func _input(event):
	if(event.is_action_pressed("escape")): # quit game
		get_tree().quit()
	if(event.is_action_pressed("tilde")): # reload scene
		get_tree().reload_current_scene()
	


func _on_root_scene_kill():
	get_tree().reload_current_scene()
