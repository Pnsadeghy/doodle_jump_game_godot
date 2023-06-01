extends StaticBody2D

func on_used():
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite2D.play("break")
	$BreakSound.call_deferred("play")
