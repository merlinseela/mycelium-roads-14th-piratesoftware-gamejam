extends StaticBody2D

@export var inventory = {
		"water": 100,
		"dirt": 100,
		"phosphorus": 100,
		"potassium": 100,
		"carbohydrates": 100,
		"protein": 100,
		"calcium": 100,
		"luciferin": 100,
		"population": 0,
		"population-max": 5
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
@onready var hud_ui_effect = hud_ui.get_node("Effect")

# Called when the node enters the scene tree for the first time.
func _ready():
	place_main_building()
	
	var start_pop = 0
	while start_pop < 5:
		spawn_npc_shroom()
		start_pop += 1
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# update HUD Inventory
	hud_ui_resources.get_node("WaterCount").text = str(inventory["water"])
	hud_ui_resources.get_node("DirtCount").text = str(inventory["dirt"])
	hud_ui_resources.get_node("PhosphorusCount").text = str(inventory["phosphorus"])
	hud_ui_resources.get_node("PotassiumCount").text = str(inventory["potassium"])
	hud_ui_resources.get_node("CarbohydratesCount").text = str(inventory["carbohydrates"])
	hud_ui_resources.get_node("ProteinCount").text = str(inventory["protein"])
	hud_ui_resources.get_node("CalciumCount").text = str(inventory["calcium"])
	hud_ui_resources.get_node("LuciferinCount").text = str(inventory["luciferin"])
	
	hud_ui_effect.get_node("PopulationCount").text = (str(inventory['population']) + '/' + str(inventory["population-max"]))

	# spawn new npc mushroom
	#if Input.is_action_just_pressed("mouse_left_button"):
		#spawn_npc_shroom()

	if (inventory["population-max"] - inventory["population"] > 0):
		if (
			inventory["water"] > 5 and
			inventory["potassium"] > 6 and 
			inventory["carbohydrates"] > 4 and
			inventory["protein"] > 3
			):
				print("spawn")
				spawn_npc_shroom()
				inventory["water"] -= 5 
				inventory["potassium"] -= 6 
				inventory["carbohydrates"] -= 4 
				inventory["protein"] -= 3
# -----------------------------
# User defined functions
# this functions spawns the main building, before spawning the building it checks if all the tiles underneath it are the right ones 
# if true then it changes the ground tiles to building/street tiles and places the building on top of it
func place_main_building():
	
	# create 
	var tileVector = tileMap.local_to_map(get_global_mouse_position())
	#var _tileData = tileMap.get_cell_tile_data(0, tileVector)
	
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
	inventory["population"] += 1
	# Every time a mushroom spawns, check if story needs to progress. 
	if(inventory["population"] == 15): 
		var event_1_scene = load("res://scenes/story/story_event_1.tscn")
		var event_1_instance = event_1_scene.instantiate()
		add_child(event_1_instance)
		print_debug("THE THING SPAWNED")
