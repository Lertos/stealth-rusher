extends Control

const MAIN_MENU_SCREEN := preload("res://scenes/ui/main_menu.tscn")
const LEVEL_TYPE_SELECT_SCREEN := preload("res://scenes/ui/level_type_select.tscn")


func _ready():
	$Panel/MainMenu.move_to_level_type_select.connect(self.load_level_type_select_screen)
	$Panel/MainMenu.move_to_options.connect(self.load_options_screen)


func load_level_type_select_screen():
	#Create a new instance of the level selector scene node
	var node = LEVEL_TYPE_SELECT_SCREEN.instantiate()
	
	#Add the new node to the panel node and remove the main menu; essentially transitioning
	$Panel.add_child(node)
	$Panel/MainMenu.queue_free()


func load_options_screen():
	#TODO: Implement options screen
	pass 
