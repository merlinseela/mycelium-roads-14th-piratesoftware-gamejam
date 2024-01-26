extends Node

var music_volume = 40

func _on_value_changed(value):
	print_debug(value, " ", music_volume)
	music_volume = value
	print_debug(value, " ", music_volume)
