extends CharacterBody2D

var movement_speed: float = 150.0
var movement_target_position: Vector2

@onready var tilemap = get_node("/root/Main/Gameworld/TileMap")
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

enum STATE{
	IDLE,
	BUSY
}

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# spawn at main building position
	spawn() # DEV: START AT MAIN
	#DEV DEBUG
	# print(get_node("/root/Main/Gameworld/shed").position)
	
	
	# Make sure to not await during _ready.
	call_deferred("actor_setup")
	
# Needed later for collison
	# print(name)

func _process(_delta):
	if Input.is_action_just_pressed("mouse_right_button"):
		movement_target_position = get_global_mouse_position()
		actor_setup()
	
func _physics_process(_delta):
	# decide on next position and move to it
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()

	# DEV: Walk from A to B 
	# DEV: localte SHED
	var shedPosition = get_node("/root/Main/Gameworld/shed").position
	# assign shed as destination
	
	if get_slide_collision_count() > 0:
		if get_slide_collision(0).get_collider().name == "shed":
			set_movement_target(get_node("/root/Main/Gameworld/MainBuilding").position)
		elif get_slide_collision(0).get_collider().name == "MainBuilding":
			set_movement_target(get_node("/root/Main/Gameworld/shed").position)

	# check if destination is reached, if so end the Agent
	if navigation_agent.is_navigation_finished():
		return
	
# if collision happens
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#print("Collided with: ", collision.get_collider().name)
	
func spawn():
# detect main building position (grid based) and set mushroom spawn position to the right tile
	var mainBuildingPos = tilemap.local_to_map(get_node("../MainBuilding").position)
	var mushroomDesiredPos = mainBuildingPos + Vector2i(1,1)
	position = tilemap.map_to_local(mushroomDesiredPos)

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target
