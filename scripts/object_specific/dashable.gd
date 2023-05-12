extends Node2D

signal set_new_destination_node(new_node: Node)

@export var left_node: Node
@export var right_node: Node
@export var up_node: Node
@export var down_node: Node


func _ready():
	set_new_destination_node.connect(get_parent().get_parent().set_new_destination)


func move_to_node(direction: int):
	if direction == Enums.direction.LEFT and left_node != null:
		set_new_node(left_node)
	elif direction == Enums.direction.RIGHT and right_node != null:
		set_new_node(right_node)
	elif direction == Enums.direction.UP and up_node != null:
		set_new_node(up_node)
	elif direction == Enums.direction.DOWN and down_node != null:
		set_new_node(down_node)


func set_new_node(new_node: Node):
	emit_signal("set_new_destination_node", new_node)
