extends CharacterBody2D

var movement_speed: float = 160.0
#var movement_speed: float = 200.0
var movement_target_position: Vector2 = Vector2(500,500)
var game_speed = 1

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# Make sure to not await during _ready.
	call_deferred("actor_setup")
	
	#Connects Mushy to the HUD speed
	var get_speed = get_node("/root/Main/HUD")
	get_speed.update_game_speed.connect(_update_speed)

func _update_speed(new_game_speed):
	game_speed = new_game_speed

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _process(_delta):
	if Input.is_action_just_pressed("mouse_right_button"):
		movement_target_position = get_global_mouse_position()
		actor_setup()
		
func _physics_process(_delta):
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed * game_speed
	move_and_slide()
