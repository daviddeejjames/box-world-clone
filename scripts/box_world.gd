extends Node2D

const FILE_BEGIN = "res://scenes/levels/box_world_level"
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
	var currentScene = get_tree().current_scene.scene_file_path
	var nextLevel = currentScene.to_int() + 1
	
	var nextLevelPath = FILE_BEGIN + str(nextLevel) + ".tscn"
	get_tree().change_scene_to_file(nextLevelPath)
