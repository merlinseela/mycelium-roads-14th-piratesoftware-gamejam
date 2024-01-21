extends Node2D

@onready var tilemap = $TileMap

# preloading all scences

var mushyScene = preload("res://scenes/units/mushy.tscn")
var mushyInstance = mushyScene.instantiate()

# load buildings
var mainBuildingScene = preload("res://scenes/buildings/main_building.tscn")
var shedScene = preload("res://scenes/buildings/shed.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Input.is_action_just_pressed("place_building_main")) == true:
		add_child(mainBuildingScene.instantiate())
	
	if (Input.is_action_just_pressed("place_building_shed")) == true:
		add_child(shedScene.instantiate())
	
	if (Input.is_action_just_pressed("place_tile_street")) == true:
		var tilePosition = get_node("TileMap").local_to_map(get_viewport().get_mouse_position())
		tilemap.set_cell(0,tilePosition,0,Vector2i(0,0),0)

	if (Input.is_action_just_pressed("place_tile_street_revert")) == true:
		pass
