extends Node

var mushyScene = preload("res://scenes/mushy.tscn")
var mushyInstance = mushyScene.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	add_child(mushyInstance)
	$mushy.position = Vector2(500,500)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
