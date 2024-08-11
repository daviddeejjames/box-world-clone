extends Node2D

const FILE_BEGIN = "res://scenes/levels/box_world_level"
var game_end = false 
const firstLevelPath = FILE_BEGIN + "1.tscn"
var first_screen_scene:PackedScene = preload(firstLevelPath)
var levelCounter = 1

func _ready():
	print(firstLevelPath)
	var firstLevel = first_screen_scene.instantiate()
	get_tree().root.add_child(firstLevel)

func _input(event):
	if !game_end:
		if Input.is_action_pressed('ui_undo'):
			_on_undo_button_pressed()
		elif Input.is_action_pressed('Reset'):
			_on_reset_button_pressed()

func _process(_delta):
	if game_end == false && $Goals: 
		var goals = $Goals.get_child_count()
		for g in $Goals.get_children():
			if g.occupied:
				goals -= 1
				
		if goals == 0:
			print("YOU WON!")
			$Timer.start()
			$UI/CompleteContainer.transition()
			game_end = true

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


func _on_win_timer_timeout():
	$Timer.wait_time = 2
	SceneTransition.transition()
	await SceneTransition.on_transistion_finished
	var currentLevelPath = FILE_BEGIN + str(levelCounter) + ".tscn"
	levelCounter = levelCounter + 1
	var nextLevelPath = FILE_BEGIN + str(levelCounter) + ".tscn"
	get_tree().root.remove_child(get_node(currentLevelPath))
	get_tree().root.add_child(get_node(nextLevelPath))
	game_end = false
	
