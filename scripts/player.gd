extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var MOUSE_SENSITIVITY:float = 0.5
@onready var playerCam = $playerCam

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _input(event):
	moveCamera(event)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	
func moveCamera(event): # handle the camera movement
	if(event is InputEventMouseMotion):
		self.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		var camRotX = (event.relative.y * MOUSE_SENSITIVITY);
		var camRotY = (event.relative.x * MOUSE_SENSITIVITY);
		playerCam.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		playerCam.rotation.x = clamp(playerCam.rotation.x, deg_to_rad(-70), deg_to_rad(70))
		#playerCam.rotation.x = clamp(playerCam.rotation.x - camRotX, -70, 70);
		#playerCam.rotation.x = clamp(playerCam.rotation.x - camRotX, -70, 70)
		#self.rotation.y = clamp(playerCam.rotation.y - camRotY, -70, 70);
