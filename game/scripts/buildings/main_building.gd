extends StaticBody2D

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

# LOAD ON INSTANCIATING
	# load npc mushroom for instancianting slaves
var npcScene = preload("res://scenes/units/npc_shroom.tscn")

# ON-READY
	#locate spawn position for building on grid via mousecursorposition 
@onready var iPosition = get_parent().get_node("TileMap").local_to_map(get_global_mouse_position())
@onready var tileMap = get_parent().get_node("TileMap")
@onready var hud_ui = get_parent().get_parent().get_node("HUD").get_node("UI")
@onready var hud_ui_resources = hud_ui.get_node("Resource")

# Called when the node enters the scene tree for the first time.
func _ready():
	place_main_building()
	
	# DEV TASK MANAGER
	# create_task(, name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# update HUD Inventory
	hud_ui_resources.get_node("WaterCount").text = str(inventory["water"])
	hud_ui_resources.get_node("DirtCount").text = str(inventory["dirt"])
	hud_ui_resources.get_node("PhosphorusCount").text = str(inventory["phosphorus"])
	hud_ui_resources.get_node("PotassiumCount").text = str(inventory["potassium"])
	hud_ui_resources.get_node("CarbohydratesCount").text = str(inventory["carbohydrates"])
	hud_ui_resources.get_node("ProteinCount").text = str(inventory["protein"])
	hud_ui_resources.get_node("CalciumCount").text = str(inventory["calcium"])
	hud_ui_resources.get_node("LuciferinCount").text = str(inventory["luciferin"])

	# spawn new npc mushroom
	if Input.is_action_just_pressed("mouse_left_button"):
		spawn_npc_shroom()

# -----------------------------
# User defined functions
# this functions spawns the main building, before spawning the building it checks if all the tiles underneath it are the right ones 
# if true then it changes the ground tiles to building/street tiles and places the building on top of it
func place_main_building():
	
	# create 
	var tileVector = tileMap.local_to_map(get_global_mouse_position())
	var tileData = tileMap.get_cell_tile_data(0, tileVector)
	
	# Debugging
	# print("TILE TYPE: " + str(tileData.get_custom_data("type")))
	
	# check tiles if true, 
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
		
		# Place image/collison Node
		position = get_parent().get_node("TileMap").map_to_local(iPosition)
		position = position - Vector2(5,0)
		
	else:
		# print("FAILED")
		queue_free() # despawn node if not placable -> making sure it is not inside the engine

func spawn_npc_shroom():
	get_parent().add_child(npcScene.instantiate())
