extends StaticBody2D

@export var inventory = {
	
}

@onready var iPosition = get_parent().get_node("TileMap").local_to_map(get_viewport().get_mouse_position())
@onready var tileMap = get_parent().get_node("TileMap")

func _ready():
	_place_shed()
	
func _process(_delta):
	pass
	

func _physics_process(delta):
	pass
	# if inventory resource empty == true -> then exetute request new resource
	# func _create_resource_request
	
func _place_shed():
	var tileVector = tileMap.local_to_map(get_viewport().get_mouse_position())
	var tileData = tileMap.get_cell_tile_data(0, tileVector)
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
	else:
		print("FAILED")
		queue_free()

func _create_resource_request():
	pass # hand over location of this building -> translates to target position
