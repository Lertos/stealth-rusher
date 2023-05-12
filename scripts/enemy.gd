extends Node2D


func _ready():
	$action_anim_player.play("idle")
	await get_tree().create_timer(RandomNumberGenerator.new().randf_range(1, 5)).timeout.connect(Callable(self, "play_die_animation"))


func play_die_animation():
	$action_anim_player.play("die")
