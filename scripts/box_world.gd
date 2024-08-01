extends Node2D

const FILE_BEGIN = "res://scenes/levels/box_world_level"
var game_end = false 

func _input(event):
	if Input.is_action_pressed('ui_undo'):
		_on_undo_button_pressed()
	elif Input.is_action_pressed('Reset'):
		_on_reset_button_pressed()

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


func _on_reset_button_pressed():
	get_tree().reload_current_scene()

func _on_undo_button_pressed():
	var player = $Player
	var boxes = $Boxes
	
	if player.lastPlayerPos.size() > 0:
		var undoDict = player.lastPlayerPos.pop_back()
		print(undoDict) # prints state we are reverting to
		var prevBoxPos = undoDict["BoxPos"]
		var prevBoxIndex = undoDict["BoxIndex"]
		player.position = undoDict["PlayerPos"]
		boxes.get_child(prevBoxIndex).position = prevBoxPos
