extends RigidBody3D


@export var decoyAlertRadius:float = 10 # metres

func _ready():
	freeze = true
	pass

func _process(delta):
	pass




func _on_noise_body_entered(body):
	$Honk.set_pitch_scale(randf_range(0.8,1.2))
	$Honk.play()
