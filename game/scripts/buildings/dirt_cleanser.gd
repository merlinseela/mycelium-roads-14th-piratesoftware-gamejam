extends StaticBody2D

@export var inventory = {
	"dirt": 0,
	"calcium": 0
}

# TASK TRACKER
@export var task_tracker = 0

@onready var iPosition = get_parent().get_node("TileMap").local_to_map(get_global_mouse_position())
@onready var tileMap = get_parent().get_node("TileMap")

func _ready():
	_place_shed()
	
func _process(_delta):
	if (Input.is_action_just_pressed("test_button")):
		print(inventory)

func _physics_process(_delta):
	# generate a lot of tasks....
	if (inventory["calcium"] - task_tracker) > 0:
		get_parent()._task_create(get_path(),"/root/Main/Gameworld/MainBuilding","calcium")
		task_tracker += 1

func _place_shed():
	var tileVector = tileMap.local_to_map(get_global_mouse_position())
	var _tileData = tileMap.get_cell_tile_data(0, tileVector)

	if (
		(tileMap.get_cell_tile_data(0, tileVector).get_custom_data("type")) == "grass" and
		(tileMap.get_cell_tile_data(0, tileVector + Vector2i(0, -1)).get_custom_data("type")) == "grass" and
		(tileMap.get_cell_tile_data(0, tileVector + Vector2i(-1,-1)).get_custom_data("type")) == "grass" and
		(tileMap.get_cell_tile_data(0, tileVector + Vector2i(-1, 0)).get_custom_data("type")) == "grass"
	):
		# IF TRUE:
		# change ground tiles to building ground
		tileMap.set_cell(0,tileVector,0,Vector2i(0,0),0)
		# change tile to another one repeat with offset
		tileMap.set_cell(0,(tileVector + Vector2i( 0,-1)),2,Vector2i(0,0),0)
		tileMap.set_cell(0,(tileVector + Vector2i(-1,-1)),2,Vector2i(0,0),0)
		tileMap.set_cell(0,(tileVector + Vector2i(-1, 0)),2,Vector2i(0,0),0)
		# place Shed Node
		position = get_parent().get_node("TileMap").map_to_local(iPosition)
		position = position - Vector2(5,20)

		# deduct costs from main building inventory
		get_parent().get_node("/root/Main/Gameworld/MainBuilding").inventory["dirt"] -= 5
		get_parent().get_node("/root/Main/Gameworld/MainBuilding").inventory["water"] -= 3

	else:
		print("FAILED")
		queue_free()

func _create_resource_request():
	pass

func _on_timer_timeout():
	if inventory["calcium"] < 3:
		inventory["calcium"] += 1
