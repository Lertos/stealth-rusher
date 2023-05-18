extends CharacterBody2D


const SPEED = 50
func _ready():
	$action_anim_player.play("idle")


func _physics_process(delta):
	var direction_horizontal = Input.get_axis("ui_left", "ui_right")
	if direction_horizontal:
		velocity.x = direction_horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	var direction_vertical = Input.get_axis("ui_up", "ui_down")
	if direction_vertical:
		velocity.y = direction_vertical * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)
