extends Node2D

enum Direction {VERTICAL, HORIZONTAL}
@export var axis_to_move: Direction

@export var tiles_to_move: int = 0
@export var move_both_directions: bool = false

@export var stop_time_in_secs: float = 0
@export var move_speed: float = 75.0

#Will be used to determine what a "tile" is when moving
var sprite_size: int

var point_one_pos: Vector2
var point_two_pos: Vector2
var destination_pos: Vector2
var distance_to_destination: Vector2
var delta_move_speed: float

var is_moving: bool = true


func _ready():
	#Play the idle animation by default
	$action_anim_player.play("idle")
	
	#Getting width only because of the nature of the spritesheet
	sprite_size = $Sprite.texture.get_height()
	
	#==Determine the two points the enemy will travel between
	
	#If moving both directions, then the start point will be your middle point\
	var total_to_move = sprite_size * tiles_to_move
	
	if move_both_directions:
		if axis_to_move == Direction.VERTICAL:
			point_one_pos = Vector2(position.x, position.y - total_to_move)
			point_two_pos = Vector2(position.x, position.y + total_to_move)
		else:
			point_one_pos = Vector2(position.x - total_to_move, position.y)
			point_two_pos = Vector2(position.x + total_to_move, position.y)
	#If only moving to a specific location, then your start point will be your point one
	else:
		point_one_pos = position
		
		if axis_to_move == Direction.VERTICAL:
			point_two_pos = Vector2(position.x, position.y + total_to_move)
		else:
			point_two_pos = Vector2(position.x + total_to_move, position.y)
	
	#Set the initial destination as point two
	destination_pos = point_two_pos
	
	#DEBUG: Fun to watch them randomly explode... but not desirable when wanting them to move!
	#await get_tree().create_timer(RandomNumberGenerator.new().randf_range(1, 5)).timeout.connect(Callable(self, "play_die_animation"))


func _process(delta):
	#Only need to run movement logic if the enemy is moving between points
	if is_moving:
		#Get the distance between the destination and the enemy
		distance_to_destination = destination_pos - position
		delta_move_speed = move_speed * delta
		
		#If the enemy is within range of the destination, just put them there so there is no glitching
		if (abs(distance_to_destination.x) < delta_move_speed and abs(distance_to_destination.y) < delta_move_speed):
			position = destination_pos
			on_destination_arrival()
			return
		
		#If the enemy is not at the destination yet, move them via their movement speed
		if axis_to_move == Direction.VERTICAL:
			if distance_to_destination.y < 0:
				position.y -= delta_move_speed
			else:
				position.y += delta_move_speed
		else:
			if distance_to_destination.x < 0:
				position.x -= delta_move_speed
			else:
				position.x += delta_move_speed


func on_destination_arrival():
	is_moving = false
	
	#Essentially reversing the direction
	if destination_pos == point_one_pos:
		destination_pos = point_two_pos
	else:
		destination_pos = point_one_pos
	
	#Check whether there is a stop/wait time inbetween movements
	if stop_time_in_secs <= 0:
		is_moving = true
	else:
		await get_tree().create_timer(stop_time_in_secs).timeout.connect(Callable(self, "start_moving"))


func start_moving():
	is_moving = true


func play_die_animation():
	$action_anim_player.play("die")
