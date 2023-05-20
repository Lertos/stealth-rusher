extends MarginContainer

signal load_level(type: String, difficulty: int, index: int)

@onready var header_label = $VB/Header
@onready var difficulty_buttons = $VB/Difficulties
@onready var levels_node = $VB/Levels
@onready var actions_buttons = $VB/Actions

var selected_type: String
var selected_difficulty: int


func load_screen(type: String):
	selected_type = type
	selected_difficulty = Enums.level_difficulty.EASY
	
	#If setup is wrong or no levels exist for this type; show them that and hide buttons
	if not LevelSetup.levels.has(type):
		header_label.text = "NO LEVELS EXIST\n FOR THIS TYPE"
		header_label.size_flags_vertical = SizeFlags.SIZE_EXPAND_FILL
		
		difficulty_buttons.visible = false
		levels_node.visible = false
		
		actions_buttons.get_node("Previous").visible = false
		actions_buttons.get_node("Next").visible = false
		
		return
	
	#If the type does exist then load all the setup data for that type only
	var level_type_dict = LevelSetup.levels[type]
	
	header_label.text = level_type_dict["display_name"]
	
	load_levels(level_type_dict["level_list"], Enums.level_difficulty.EASY)


func load_levels(level_type_dict: Dictionary, difficulty: int):
	#If the setup doesn't have this difficulty then return
	if not level_type_dict.has(difficulty):
		return
	
	var difficulty_level_dict = level_type_dict[difficulty]
	
	#If there are no levels for this difficulty then return
	if difficulty_level_dict == []:
		return
	
	#Making sure there are children
	if levels_node.get_child_count() == 0:
		return
	
	var current_row_index = 0
	var current_col_index = 0
	
	var current_row_node = levels_node.get_child(current_row_index)
	
	#Making sure there are children
	if current_row_node.get_child_count() == 0:
		return
	
	var current_col_node = current_row_node.get_child(current_col_index)
	var level_index = 0
	
	#Loads all of the levels; renaming, setting level text, and making visible
	for level_dict in difficulty_level_dict:
		current_col_index += 1
		
		#Check if we need to use the next row
		if current_col_index > current_row_node.get_child_count():
			#Use the next row list
			current_row_index += 1
			#Reset the column to the start of the row list
			current_col_index = 0
			
			#Check if we have any more rows to use
			if current_row_index > levels_node.get_child_count():
				return
			
			current_row_node = levels_node.get_child(current_row_index)
		
		current_col_node = current_row_node.get_child(current_col_index)
		load_level_data(current_col_node, level_dict, level_index)
		
		#Increase the array index
		level_index += 1


func load_level_data(level_node: Node, level_dict: Dictionary, level_index: int):
	level_node.text = level_dict["level_number"]
	level_node.name = level_dict["scene_file_name"]
	level_node.visible = true
	
	if not level_dict["unlocked"]:
		level_node.disabled = true
	
	level_node.pressed.connect(get_tree().current_scene.change_level.bind(selected_type, selected_difficulty, level_index))
