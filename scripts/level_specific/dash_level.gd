extends Node2D

signal player_moved(direction: int)
signal player_started_moving
signal player_stopped_moving

@export var beginning_node: Node

@onready var player = $player

var start_node: Node
var destination_node: Node

var distance_to_destination: Vector2 = Vector2.ZERO
var player_velocity: Vector2 = Vector2.ZERO

var move_speed: float = 200.0
var delta_move_speed: float

var is_moving: bool = false


func _ready():
	#Setup the player animations for visibility
	player_started_moving.connect(player.set_visibility_visible)
	player_stopped_moving.connect(player.set_visibility_invisible)
	
	#Default the player to be hidden as they start in a dashable
	emit_signal("player_stopped_moving")
	
	#Setup the start node to the node assigned to the level as the "beginning node"
	start_node = beginning_node
	player.position = start_node.position
	
	#Connect the signal to the start node; we'll handle other signals later
	player_moved.connect(start_node.move_to_node)


func _unhandled_key_input(event):
	#Do not allow the player to switch directions mid way through movement
	if not is_moving:
		if Input.is_action_just_pressed("left"):
			emit_signal("player_moved", Enums.direction.LEFT)
		elif Input.is_action_just_pressed("right"):
			emit_signal("player_moved", Enums.direction.RIGHT)
		elif Input.is_action_just_pressed("up"):
			emit_signal("player_moved", Enums.direction.UP)
		elif Input.is_action_just_pressed("down"):
			emit_signal("player_moved", Enums.direction.DOWN)


func _process(delta):
	#Only need to run movement logic if the player is moving between nodes
	if is_moving:
		#Get the distance between the destination node and the player
		distance_to_destination = abs(destination_node.position - player.position)
		delta_move_speed = move_speed * delta
		
		#If the player is within range of the destination, just put them there so there is no glitching
		if (distance_to_destination.x < delta_move_speed and distance_to_destination.y < delta_move_speed):
			player.position = destination_node.position
			on_destination_arrival()
			return
		
		#If the player is not at the destination yet, we need to move them there at the correct diagonal
		var angle = player.get_angle_to(destination_node.position)
		
		#Don't ask, this is just the math to get the exact direction between two points
		player_velocity.x = cos(angle)
		player_velocity.y = sin(angle)
		
		#Move the player based on the required velocity as well as taking the delta into account
		player.position += player_velocity * delta_move_speed


func set_new_destination(new_node: Node):
	#Need to tell the process function we are now moving towards a new destination
	is_moving = true
	destination_node = new_node
	
	#Let the player script know we started moving
	emit_signal("player_started_moving")

	#Remove the old signal so it doesn't try to move you to the wrong node
	player_moved.disconnect(start_node.move_to_node)
	#Connect the signal to the new destination so it knows which nodes you can move to
	player_moved.connect(destination_node.move_to_node)


func on_destination_arrival():
	#When we arrive, the destination now becomes our new start node
	is_moving = false
	start_node = destination_node
	
	#Let the player script know we started moving
	emit_signal("player_stopped_moving")
