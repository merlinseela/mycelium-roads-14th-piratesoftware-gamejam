extends StaticBody2D

@onready var iPosition = get_parent().get_node("TileMap").local_to_map(get_viewport().get_mouse_position())
@onready var tileMap = get_parent().get_node("TileMap")

# Called when the node enters the scene tree for the first time.
func _ready():
	var tileVector = tileMap.local_to_map(get_viewport().get_mouse_position())
	var tileData = tileMap.get_cell_tile_data(0, tileVector)
	print("TILE TYPE: " + str(tileData.get_custom_data("type")))
	
	if (
		# check for grass tiles on 6 tiles
		(
			(tileMap.get_cell_tile_data(0, tileVector).get_custom_data("type")) == "grass" and
			(tileMap.get_cell_tile_data(0, tileVector + Vector2i( 0,-1)).get_custom_data("type")) == "grass" and
			(tileMap.get_cell_tile_data(0, tileVector + Vector2i(-1,-1)).get_custom_data("type")) == "grass" and
			(tileMap.get_cell_tile_data(0, tileVector + Vector2i(-1, 0)).get_custom_data("type")) == "grass" and
			(tileMap.get_cell_tile_data(0, tileVector + Vector2i( 0, 1)).get_custom_data("type")) == "grass" and
			(tileMap.get_cell_tile_data(0, tileVector + Vector2i( 0, 1)).get_custom_data("type")) == "grass"
		)
		 and
		# check for street or grass tiles on 2 tiles
			(
				((tileMap.get_cell_tile_data(0, tileVector + Vector2i( 1, 1)).get_custom_data("type")) == "street" or "grass")
				and
				((tileMap.get_cell_tile_data(0, tileVector + Vector2i( 2, 2)).get_custom_data("type")) == "street" or "grass")
			)
		):
		# IF TRUE:
		# Change ground tiles to building ground
		tileMap.set_cell(0,tileVector,2,Vector2i(0,0),0)
		# change tile to another one repeat with offset
		tileMap.set_cell(0,(tileVector + Vector2i( 0,-1)),2,Vector2i(0,0),0)
		tileMap.set_cell(0,(tileVector + Vector2i(-1,-1)),2,Vector2i(0,0),0)
		tileMap.set_cell(0,(tileVector + Vector2i(-1, 0)),2,Vector2i(0,0),0)
		tileMap.set_cell(0,(tileVector + Vector2i( 0, 1)),2,Vector2i(0,0),0)
		tileMap.set_cell(0,(tileVector + Vector2i( 1, 0)),2,Vector2i(0,0),0)
		# street tiles -> entrance
		tileMap.set_cell(0,(tileVector + Vector2i( 1, 1)),0,Vector2i(0,0),0)
		tileMap.set_cell(0,(tileVector + Vector2i( 2, 2)),0,Vector2i(0,0),0)
		#Place Shed Node
		position = get_parent().get_node("TileMap").map_to_local(iPosition)
		position = position - Vector2(5,0)
	else:
		print("FAILED")
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
