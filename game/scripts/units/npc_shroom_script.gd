extends CharacterBody2D

@export var inventory = {
		"water": 0,
		"dirt": 0,
		"phosphorus": 0,
		"potassium": 0,
		"carbohydrates": 0,
		"protein": 0,
		"calcium": 0,
		"luciferin": 0
}

var movement_speed: float = 150.0
var movement_target_position: Vector2

@onready var tilemap = get_node("/root/Main/Gameworld/TileMap")
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

enum STATE{
	IDLE,
	BUSY
}

enum STATETASK{
	NOTATFROMBUILDING,
	EXECUTETASKATFROMBUILDING,
	NOTATTOBUILDING,
	EXECUTETASKATTOBUILDING
}

var state_tracker
var state_task_tracker
var loaded_task
var load_task_success_tracker

func _ready():
	state_tracker = STATE.IDLE
	load_task_success_tracker = false
	
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# spawn at main building position
	spawn() # DEV: START AT MAIN

	# Make sure to not await during _ready.
	call_deferred("actor_setup")	
func _process(_delta):
	if state_tracker == STATE.IDLE:
		load_idle_task()
		if loaded_task != null: 
			state_tracker = STATE.BUSY

	# configuring the execution of the task
	if state_tracker == STATE.BUSY and load_task_success_tracker == false:
		actor_setup()
		load_task_success_tracker = true
		state_task_tracker = STATETASK.NOTATFROMBUILDING

	# executing task
	if state_tracker == STATE.BUSY and load_task_success_tracker == true:
		match state_task_tracker:
		# move to NotAtFromBuilding
			STATETASK.NOTATFROMBUILDING:
				set_movement_target(get_node(loaded_task.from_building).position)
				if get_slide_collision_count() > 0:
					if get_slide_collision(0).get_collider().name == get_node(loaded_task.from_building).name:
						state_task_tracker = STATETASK.EXECUTETASKATFROMBUILDING
		# pickup resource
			STATETASK.EXECUTETASKATFROMBUILDING:
				# decrese building inventory
				# print("OLD B INV: " + str(get_node(loaded_task.from_building).inventory[loaded_task.resource]))
				get_node(loaded_task.from_building).inventory[loaded_task.resource] -= 1
				#print("NEW B INV: " + str(get_node(loaded_task.from_building).inventory[loaded_task.resource]))
				# increase personal inventory
				#print("OLD P INV: " + str(inventory[loaded_task.resource]))
				inventory[loaded_task.resource] += 1
				#print("NEW P INV: " + str(inventory[loaded_task.resource]))
				state_task_tracker = STATETASK.NOTATTOBUILDING
				
		# walk to to_building
			STATETASK.NOTATTOBUILDING:
				set_movement_target(get_node(loaded_task.to_building).position)
				if get_slide_collision_count() > 0:
					if get_slide_collision(0).get_collider().name == get_node(loaded_task.to_building).name:
						state_task_tracker = STATETASK.EXECUTETASKATTOBUILDING
		
		# putdown resource
			STATETASK.EXECUTETASKATTOBUILDING:
				inventory[loaded_task.resource] -= 1
				get_node(loaded_task.to_building).inventory[loaded_task.resource] += 1
				#print("MAIN BUILDING INV: " + str(get_node(loaded_task.to_building).inventory))
				
				set_task_done()
				state_tracker = STATE.IDLE
				load_task_success_tracker = false

func _physics_process(_delta):
	# decide on next position and move to it _> DO NOT TOUCH!!!!
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
	if navigation_agent.is_navigation_finished():
		return
	
func spawn():
# detect main building position (grid based) and set mushroom spawn position to the right tile
	var mainBuildingPos = tilemap.local_to_map(get_node("../MainBuilding").position)
	var mushroomDesiredPos = mainBuildingPos + Vector2i(1,1)
	position = tilemap.map_to_local(mushroomDesiredPos)
	movement_target_position = get_parent().get_node("/root/Main/Gameworld/MainBuilding").position
	actor_setup()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target
	
func load_idle_task():
	for task in get_parent().tasks:
		if task.status == get_parent().TASKSTATUS.IDLE:
			loaded_task = task
			task.status = get_parent().TASKSTATUS.INPROCESS
			break
		else:
			loaded_task = null

func set_task_done():
	for task in get_parent().tasks:
		if task.task_id == loaded_task.task_id:
			task.status = get_parent().TASKSTATUS.DONE
			get_node(loaded_task.from_building).task_tracker -= 1
			break
