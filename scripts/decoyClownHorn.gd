extends RigidBody3D


@export var decoyAlertRadius:float = 10 # metres

func _ready():
	#$decoyAlertArea/CollisionShape3D.get_shape() = decoyAlertRadius
	pass

func _process(delta):
	pass
