extends Control

@onready var button_group = $Panel/VB/MarginContainer/VB


func on_start_button_chosen():
	#TODO: This is temporary; it should open the level selector (preloaded scene)
	get_tree().change_scene_to_file("res://scenes/levels/dash_level.tscn")


func on_options_button_chosen():
	#TODO: Implement whenever
	pass


func on_quit_button_chosen():
	get_tree().quit()
