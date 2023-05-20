extends Control

const MAIN_MENU_SCREEN := preload("res://scenes/ui/main_menu.tscn")
const LEVEL_TYPE_SELECT_SCREEN := preload("res://scenes/ui/level_type_select.tscn")
const LEVEL_SELECT_SCREEN := preload("res://scenes/ui/level_select.tscn")

@onready var panel_node = $Panel


func _ready():
	load_main_menu_screen()


#Removes all menus from the panel; useful to call before loading a new screen
func remove_panel_children():
	for child in panel_node.get_children():
		child.queue_free()


func load_main_menu_screen():
	remove_panel_children()
	
	var node = MAIN_MENU_SCREEN.instantiate()
	
	panel_node.add_child(node)
	
	#Connect the signals
	node.move_to_level_type_select.connect(self.load_level_type_select_screen)
	node.move_to_options.connect(self.load_options_screen)


func load_level_type_select_screen():
	remove_panel_children()
	
	var node = LEVEL_TYPE_SELECT_SCREEN.instantiate()
	
	panel_node.add_child(node)
	
	#Connect the signals
	node.move_from_type_select_to_main_menu.connect(self.load_main_menu_screen)
	node.move_to_level_select.connect(self.load_level_select_screen)


func load_level_select_screen(type: String):
	remove_panel_children()
	
	var node = LEVEL_SELECT_SCREEN.instantiate()
	
	panel_node.add_child(node)
	
	#Load the initial setup
	node.load_screen(type)
	
	#Connect the signals
	#node.move_from_type_select_to_main_menu.connect(self.load_main_menu_screen)


func load_options_screen():
	#TODO: Implement options screen
	pass 
