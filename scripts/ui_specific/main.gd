extends Control

const LEVEL_TYPE_SELECT_SCREEN := preload("res://scenes/ui/level_type_select.tscn")


func _ready():
	$Panel/MainMenu.move_to_level_type_select.connect(self.load_level_type_select_screen)


func load_level_type_select_screen():
	var node = LEVEL_TYPE_SELECT_SCREEN.instantiate()
	$Panel.add_child(node)
	$Panel/MainMenu.queue_free()
	
	
