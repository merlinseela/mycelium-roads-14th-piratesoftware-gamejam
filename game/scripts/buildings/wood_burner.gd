extends StaticBody2D

@export var inventory = {
	"potassium": 0
}

# TASK TRACKER
@export var task_tracker = 0

# ON-READY
	#locate spawn position for building on grid via mousecursorposition 
@onready var iPosition = get_parent().get_node("TileMap").local_to_map(get_global_mouse_position())
@onready var tileMap = get_parent().get_node("TileMap")

# Called when the node enters the scene tree for the first time.
func _ready():
	_place_building()

func _process(_delta):
	if (inventory["potassium"] - task_tracker) > 0:
		get_parent()._task_create(get_path(),"/root/Main/Gameworld/MainBuilding","potassium")
		task_tracker += 1

	if Input.is_action_just_pressed("test_button"):
		#print(task_tracker)
		#print(inventory["dirt"])
		pass

func _place_building():
	var tileVector = tileMap.local_to_map(get_global_mouse_position())
	var _tileData = tileMap.get_cell_tile_data(0, tileVector)
	# DEBUGGING
	#print("TILE TYPE: " + str(tileData.get_custom_data("type")))
	
	if (
		(tileMap.get_cell_tile_data(0, tileVector).get_custom_data("type")) == "grass" and
		(tileMap.get_cell_tile_data(0, tileVector + Vector2i(0, -1)).get_custom_data("type")) == "grass" and
		(tileMap.get_cell_tile_data(0, tileVector + Vector2i(-1,-1)).get_custom_data("type")) == "grass" and
		(tileMap.get_cell_tile_data(0, tileVector + Vector2i(-1, 0)).get_custom_data("type")) == "grass"
	):
		# IF TRUE:
		# Change ground tiles to building ground
		tileMap.set_cell(0,tileVector,0,Vector2i(0,0),0)
		# change tile to another one repeat with offset
		tileMap.set_cell(0,(tileVector + Vector2i( 0,-1)),2,Vector2i(0,0),0)
		tileMap.set_cell(0,(tileVector + Vector2i(-1,-1)),2,Vector2i(0,0),0)
		tileMap.set_cell(0,(tileVector + Vector2i(-1, 0)),2,Vector2i(0,0),0)
		#Place Shed Node
		position = get_parent().get_node("TileMap").map_to_local(iPosition)
		position = position - Vector2(5,20)
		
		# deduct costs from main building inventory
		get_parent().get_node("/root/Main/Gameworld/MainBuilding").inventory["dirt"] -= 20
		get_parent().get_node("/root/Main/Gameworld/MainBuilding").inventory["calcium"] -= 10
		get_parent().get_node("/root/Main/Gameworld/MainBuilding").inventory["luciferin"] -= 10
		
	else:
		print("FAILED")
		queue_free()
# configuration of timer via godot! -> not in code!
# create 1 resource whenever timer reaches 0
func _on_timer_timeout():
	if inventory["potassium"] < 3:
		inventory["potassium"] += 1
