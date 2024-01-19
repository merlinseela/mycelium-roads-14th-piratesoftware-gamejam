extends Node2D

@onready var tilemap = $TileMap

# preloading all scences

var npcScene = preload("res://scenes/npc_shroom.tscn")
# var npcInstance = npcScene.instantiate()

var mushyScene = preload("res://scenes/mushy.tscn")
var mushyInstance = mushyScene.instantiate()

var shedScene = preload("res://scenes/buildings/shed.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#add_child(mushyInstance)
	#$mushy.position = Vector2(500,500)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("mouse_left_button"):
		add_child(npcScene.instantiate())

	if (Input.is_action_just_pressed("mouse_middle_button")) == true:
		add_child(shedScene.instantiate())
		
		# Detect tile on cursor and return tile coordinates
		print(tilemap.local_to_map(get_viewport().get_mouse_position()))
		
		
		
		

