extends Area2D

var occupied = false

func _on_body_entered(body):
	if body.is_in_group('box'):
		$GoalSFX.play()
		occupied = true

func _on_body_exited(body):
	if body.is_in_group('box'):
		occupied = false
