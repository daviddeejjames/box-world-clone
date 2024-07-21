extends Node2D

var game_end = false 

func _process(_delta):
	if game_end == false: 
		var goals = $Goals.get_child_count()
		for g in $Goals.get_children():
			if g.occupied:
				goals -= 1
				
		if goals == 0:
			print("YOU WON!")
			$AcceptDialog.popup()
			game_end = true

func _on_accept_dialog_confirmed():
	get_tree().reload_current_scene()
