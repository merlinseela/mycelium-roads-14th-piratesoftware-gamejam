extends Node2D

# Tast Manager
class Task:
	var task_id # incremented id of task
	var from_building # path of node
	var to_building # path of node
	var resource # which resource to be transported
	var status # idle, started, done

var task_id = 0
@export var tasks = []

enum TASKSTATUS {
	IDLE,
	INPROCESS,
	DONE,
	}
@export var task_status: TASKSTATUS


# Building Manager
class Building:
	var building_id # incremented id of building
	var node_path # will hold the node_name for accessing information of the entity
	var building # will hold what building it is
	var location # will hold the global position of the building

var building_id = 0
@export var buildings = []

# access tilemap
@onready var tilemap = $TileMap

# preloading all scences
var mushyScene = preload("res://scenes/units/mushy.tscn")
var mushyInstance = mushyScene.instantiate()
	# preload buildings
var building_main_scene = preload("res://scenes/buildings/main_building.tscn")
var building_dirt_cleanser_scene = preload("res://scenes/buildings/dirt_cleanser.tscn")
var building_dirt_hole_scene = preload("res://scenes/buildings/dirt_hole.tscn")
var building_earthworm_farm_scene = preload("res://scenes/buildings/earthworm_farm.tscn")
var building_house_tent_scene = preload("res://scenes/buildings/house_tent.tscn")
var building_house_shed_scene = preload("res://scenes/buildings/house_shed.tscn")
var building_house_house_scene = preload("res://scenes/buildings/house_house.tscn")
var building_phosphorus_quarry_scene = preload("res://scenes/buildings/phosphorus_quarry.tscn")
var building_well_scene = preload("res://scenes/buildings/well.tscn")
var building_wheat_farm_scene = preload("res://scenes/buildings/wheat_farm.tscn")
var building_wood_burner_scene = preload("res://scenes/buildings/wood_burner.tscn")
var building_wood_decayer_scene = preload("res://scenes/buildings/wood_decayer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# cleanup tasks list
	var task_delete_index = []
	var task_delete_number = 0
	var task_delete_index_offset = 0
	for task in tasks:
		if task.status == TASKSTATUS.DONE:
			task_delete_index.append(task_delete_number)
		task_delete_number += 1
	for task_index in task_delete_index:
		tasks.pop_at(task_index - task_delete_index_offset)
		task_delete_index_offset += 1

	# place buildings
	if (Input.is_action_just_pressed("place_building_main")) == true:
		var main_building = building_main_scene.instantiate()
		add_child(main_building)
		# create new entry in building list
		# _building_create(main_building.get_path(), "main", main_building.position)
	
		# buildings houseing
	if (Input.is_action_just_pressed("place_building_tent")) == true:
		add_child(building_house_tent_scene.instantiate())		
	if (Input.is_action_just_pressed("place_building_shed")) == true:
		add_child(building_house_shed_scene.instantiate())
	if (Input.is_action_just_pressed("place_building_house")) == true:
		add_child(building_house_house_scene.instantiate())
		
		
		# building industry
	if (Input.is_action_just_pressed("place_building_dirt_hole")) == true:
		add_child(building_dirt_hole_scene.instantiate())
	if (Input.is_action_just_pressed("place_building_dirt_cleanser")) == true:
		add_child(building_dirt_cleanser_scene.instantiate())
	if (Input.is_action_just_pressed("place_building_earthworm_farm")) == true:
		add_child(building_earthworm_farm_scene.instantiate())
	if (Input.is_action_just_pressed("place_building_phosphorus_quarry")) == true:
		add_child(building_phosphorus_quarry_scene.instantiate())
	if (Input.is_action_just_pressed("place_building_well")) == true:
		add_child(building_well_scene.instantiate())
	if (Input.is_action_just_pressed("place_building_wheat_farm")) == true:
		add_child(building_wheat_farm_scene.instantiate())
	if (Input.is_action_just_pressed("place_building_wood_burner")) == true:
		add_child(building_wood_burner_scene.instantiate())
	if (Input.is_action_just_pressed("place_building_wood_decayer")) == true:
		add_child(building_wood_decayer_scene.instantiate())

	# tiles
	if (Input.is_action_just_pressed("place_tile_street")) == true:
		var tilePosition = tilemap.local_to_map(get_global_mouse_position())
		if (
			(tilemap.get_cell_tile_data(0, tilePosition).get_custom_data("type")) != "street" and
			(tilemap.get_cell_tile_data(0, tilePosition).get_custom_data("type")) != "building"
		):
			tilemap.set_cell(0,tilePosition,0,Vector2i(0,0),0)
			get_node("MainBuilding").inventory["dirt"] -= 2

	if (Input.is_action_just_pressed("place_tile_street_revert")) == true:
		var tilePosition = tilemap.local_to_map(get_global_mouse_position())
		if (
			(tilemap.get_cell_tile_data(0, tilePosition).get_custom_data("type")) == "street"
		):
			tilemap.set_cell(0,tilePosition,1,Vector2i(0,0),0)

	# deletion
	if (Input.is_action_just_pressed("delete")) == true:
		pass # delete keybind not yet set! -> input map

	# test button and debugging
	if (Input.is_action_just_pressed("test_button")) == true:
		pass
		
func _building_create(node_name, building, location):
	building_id += 1
	var new_building = Building.new()
	new_building.node_path = node_name
	new_building.building = building
	new_building.location = location
	buildings.append(new_building)

func _task_create(from_building, to_building, resource):
	# increment task number by 1
	task_id += 1
	var newTask = Task.new()
	newTask.task_id = task_id
	newTask.from_building = from_building
	newTask.to_building = to_building
	newTask.resource = resource
	newTask.status = TASKSTATUS.IDLE
	tasks.append(newTask)

func _task_start():
	pass

# for now no deletion!
func _task_done():
	for task in tasks.size():
		if tasks[task].status == TASKSTATUS.DONE:
			print(task)

#------------------------------
# DEBUG AND TEST FUNCTIONS!
func _call_test():
	print("I WAS CALLED: GAMEWORLD")
	
func _debug_task_manager_status():
	print(tasks)
	var i = 0
	for task in tasks:
		i += 1
	print("TASK COUNT: " + str(i))
	# task idle
	i = 0
	for task in tasks:
		if task.status == TASKSTATUS.IDLE:
			i += 1
	print("TASK IDLE COUNT: " + str(i))
	# task in inprocess
	i = 0
	for task in tasks:
		if task.status == TASKSTATUS.INPROCESS:
			i += 1
	print("TASK INPROCESS COUNT: " + str(i))
	# task done
	i = 0
	for task in tasks:
		if task.status == TASKSTATUS.DONE:
			i += 1
	print("TASK DONE COUNT: " + str(i))
