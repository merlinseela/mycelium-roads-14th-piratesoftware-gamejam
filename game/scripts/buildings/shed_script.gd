extends StaticBody2D

@onready var iPosition = get_parent().get_node("TileMap").local_to_map(get_viewport().get_mouse_position())
@onready var tileMap = get_parent().get_node("TileMap")

func _ready():
	var cell_origin = tileMap.local_to_map(get_viewport().get_mouse_position())
	
	# Change ground tiles to building ground
	tileMap.set_cell(
		0, 
		cell_origin,
		2,
		Vector2i(0,0),
		0
		)
		# change tile to another one repeat with offset
	tileMap.set_cell(
		0, 
		(cell_origin + Vector2i(0,-1)),
		2,
		Vector2i(0,0),
		0
		)
	tileMap.set_cell(
		0, 
		(cell_origin + Vector2i(-1,-1)),
		2,
		Vector2i(0,0),
		0
		)
	tileMap.set_cell(
		0, 
		(cell_origin + Vector2i(-1,0)),
		2,
		Vector2i(0,0),
		0
		)
	
	position = get_parent().get_node("TileMap").map_to_local(iPosition)
	position = position - Vector2(5,20)
	
func _physics_process(delta):
	pass


