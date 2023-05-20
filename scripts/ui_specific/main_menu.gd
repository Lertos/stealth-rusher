extends Control

signal move_to_level_type_select
signal move_to_options


func on_start_button_chosen():
	emit_signal("move_to_level_type_select")


func on_options_button_chosen():
	emit_signal("move_to_options")


func on_quit_button_chosen():
	get_tree().quit()
