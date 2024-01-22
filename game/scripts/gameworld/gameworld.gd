extends Node2D

@onready var tilemap = $TileMap

# preloading all scences
var mushyScene = preload("res://scenes/units/mushy.tscn")
var mushyInstance = mushyScene.instantiate()

# preload buildings
var building_main_scene = preload("res://scenes/buildings/main_building.tscn")
var building_dirtcleanser_scene = preload("res://scenes/buildings/dirt_cleanser.tscn")
var building_dirthole_scene = preload("res://scenes/buildings/dirt_hole.tscn")
var building_earthworm_farm_scene = preload("res://scenes/buildings/earthworm_farm.tscn")
var building_house_tent_scene = preload("res://scenes/buildings/house_tent.tscn")
var building_house_shed_scene = preload("res://scenes/buildings/house_shed.tscn")
var building_house_house_scene = preload("res://scenes/buildings/house_house.tscn")
var building_phosphorus_quarry = preload("res://scenes/buildings/phosphorus_quarry.tscn")
var building_well = preload("res://scenes/buildings/well.tscn")
var building_wheat_farm = preload("res://scenes/buildings/wheat_farm.tscn")
var building_wood_burner = preload("res://scenes/buildings/wood_burner.tscn")
var building_wood_decayer = preload("res://scenes/buildings/wood_decayer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# check for input if true place
	if (Input.is_action_just_pressed("place_building_main")) == true:
		add_child(building_main_scene.instantiate())
	
	if (Input.is_action_just_pressed("place_building_shed")) == true:
		add_child(building_house_shed_scene.instantiate())
	
	if (Input.is_action_just_pressed("place_tile_street")) == true:
		var tilePosition = get_node("TileMap").local_to_map(get_viewport().get_mouse_position())
		tilemap.set_cell(0,tilePosition,0,Vector2i(0,0),0)

	if (Input.is_action_just_pressed("place_tile_street_revert")) == true:
		pass
		
	if (Input.is_action_just_pressed("test_button")) == true:
		print(get_node_or_null("/root/Main/Gameworld/MainBuilding").inventory)
