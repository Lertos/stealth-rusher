extends Node2D

@export var beginning_node: Node

@onready var player = $Player

var start_node: Node
var destination_node: Node

var move_speed: float = 16.0


func _ready():
	start_node = beginning_node

func _unhandled_key_input(event):
	if Input.is_action_pressed("ui_right"):


func _physics_process(delta):
	


func move_player():
	

