extends Node2D


func _ready():
	$action_anim_player.play("idle")


func set_visibility_invisible():
	$visiblility_anim_player.play("turn_invisible")


func set_visibility_visible():
	$visiblility_anim_player.play("turn_visible")
