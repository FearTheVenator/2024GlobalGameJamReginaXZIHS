extends CharacterBody3D

var current_speed = 0
@export var SPEED = 7.0
const SPEED_RUNNING_MULTIPLIER = 1.4
var SPEED_RUNNING_MULTIPLIER_CURRENT = 1.0
const JUMP_VELOCITY = 30
var MOUSE_SENSITIVITY = 0.5
var isAiming:bool = false
@export var horn_count = 1
@onready var playerCam = $playerCam
@onready var decoyClownHorn = preload("res://scenes/decoy_clown_horn.tscn")
var decoyInstance
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	velocity = Vector3.ZERO # minor null bugfix

func _input(event):
	moveCamera(event)
	if isRunning():
		SPEED_RUNNING_MULTIPLIER_CURRENT = SPEED_RUNNING_MULTIPLIER
	else:
		SPEED_RUNNING_MULTIPLIER_CURRENT = 1.0
	
	if(event.is_action_pressed("right_click")and horn_count > 0):
		aimProjectile()
	if(event.is_action_released("right_click") and isAiming):
		throwProjectile(decoyInstance)
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * SPEED_RUNNING_MULTIPLIER_CURRENT
		velocity.z = direction.z * SPEED * SPEED_RUNNING_MULTIPLIER_CURRENT
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * SPEED_RUNNING_MULTIPLIER_CURRENT)
		velocity.z = move_toward(velocity.z, 0, SPEED * SPEED_RUNNING_MULTIPLIER_CURRENT)
	if velocity.length() == 0:
		pass
		#code animation stuff here
	elif is_on_floor():
		#code more animation stuff here
		if $Timer.time_left <=0:
			$Footsteps.set_pitch_scale(randf_range(0.8,1.2))
			$Footsteps.set_volume_db(randf_range(-15,-13))
			$Footsteps.play(randf_range(0,.23))
			if isRunning():
				$Timer.start(0.3)
			else:
				$Timer.start(0.5)
	move_and_slide()

func moveCamera(event): # handle the camera movement
	if(event is InputEventMouseMotion):
		#self.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		rotation.y += deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1)
		#var camRotX = (event.relative.y * MOUSE_SENSITIVITY);
		#var camRotY = (event.relative.x * MOUSE_SENSITIVITY);
		#playerCam.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		#playerCam.rotation.x = clamp(playerCam.rotation.x, deg_to_rad(-70), deg_to_rad(70))
		
	
func isRunning() -> bool:
	return Input.is_action_pressed("shift")

func aimProjectile():
	print("aiming projectile...")
	isAiming = true
	decoyInstance = decoyClownHorn.instantiate() # spawn preloaded projectile
	decoyInstance.position = $ProjectileOrigin.position
	self.add_child(decoyInstance)
	pass

func throwProjectile(newDecoyProjectile):
	print("Throwing projectile...")
	isAiming = false
	newDecoyProjectile.reparent(self.get_parent())
	newDecoyProjectile.freeze = false # unfreeze projectile physics to throw it (see decoy ready func)
	# add velocity to projectile to throw it
	var forwardVector = transform.basis.z.normalized()
	newDecoyProjectile.linear_velocity -= forwardVector.rotated(transform.basis.x, deg_to_rad(45)) * 15
	# add some angular velocity to make it spin so it looks better
	randomize()
	newDecoyProjectile.angular_velocity += Vector3(randf()*2,randf(),3)
	# enable visual effects on decoy
	newDecoyProjectile.get_node("decoyLight").visible = true
	newDecoyProjectile.get_node("decoyParticles").emitting = true
	horn_count -= 1
	pass
