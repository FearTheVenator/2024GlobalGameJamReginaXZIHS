extends CharacterBody3D

@export var movement_speed: float = 2.0
@export var movement_target_position: Vector3 = Vector3(0.5,0.0,-3)
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
var tar_rot : float
var chasing_player:bool = false
var player: Node3D
func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.5
	# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	if chasing_player == true:
		navigation_agent.set_target_position(player.get_position())
	elif navigation_agent.is_navigation_finished():
		movement_target_position = Vector3(randf_range(-100,100),0.0,randf_range(-100,100))
		navigation_agent.set_target_position(movement_target_position)
		while !navigation_agent.is_target_reachable():
			movement_target_position = Vector3(randf_range(-100,100),0.0,randf_range(-100,100))
			navigation_agent.set_target_position(movement_target_position)

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	#var cop_dir = next_path_position - current_agent_position
	tar_rot = atan2(velocity.x, velocity.z)
	rotation.y = lerp_angle(rotation.y, tar_rot,0.1)
	move_and_slide()


#func _on_character_detector_body_entered(body):
	#print(body)
	#if body.name == "player":
		#chasing_player = true
		#player = body.get_parent()
		#navigation_agent.set_target_position(body.position)
	#else:
		#while !navigation_agent.is_target_reachable():
			#movement_target_position = Vector3(randf_range(-100,100),0.0,randf_range(-100,100))
			#navigation_agent.set_target_position(movement_target_position)
		
