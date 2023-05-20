extends Control

const MAIN_MENU_SCREEN := preload("res://scenes/ui/main_menu.tscn")
const LEVEL_TYPE_SELECT_SCREEN := preload("res://scenes/ui/level_type_select.tscn")
const LEVEL_SELECT_SCREEN := preload("res://scenes/ui/level_select.tscn")

@onready var panel_node = $Panel
@onready var current_level_node = $CurrentLevel


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


func change_level(type: String, difficulty: int, level_index: int):
	var level_type_dict = LevelSetup.levels[type]
	var level_data_dict = level_type_dict["level_list"][difficulty][level_index]
	var path_of_scene_file = level_type_dict["location_of_levels"] + level_data_dict["scene_file_name"] + ".tscn"
	
	if ResourceLoader.exists(path_of_scene_file, "PackedScene"):
		var level_node = load(path_of_scene_file).instantiate()
		
		panel_node.visible = false
		current_level_node.add_child(level_node)


func load_options_screen():
	#TODO: Implement options screen
	pass 
