extends StaticBody2D

var jump_force = 2

func on_used():
	$JumpSound.call_deferred("play")

func _on_visible_on_screen_notifier_2d_screen_exited():
	get_parent().queue_free()
