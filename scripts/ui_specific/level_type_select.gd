extends MarginContainer

signal move_from_type_select_to_main_menu
signal move_to_level_select(type: String)


func on_main_menu_pressed():
	emit_signal("move_from_type_select_to_main_menu")

#=========================
#All level type listeners
#=========================

func select_dashing_level():
	emit_signal("move_to_level_select", "dashing")


func select_freeroam_level():
	emit_signal("move_to_level_select", "freeroam")
