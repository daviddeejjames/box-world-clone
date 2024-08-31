extends Node2D

# Gameplay variables
@export var level_list: Array[PackedScene]
@onready var completeScreen := $UI/CompleteContainer
var _level_counter: int = 0
var _game_end := false
var _timer: Timer = null

func _ready():
	LevelManager.set_main_scene(self)
	LevelManager.load_next_level(level_list[_level_counter])

func _input(event):
	if !_game_end:
		if Input.is_action_pressed('ui_undo'):
			_on_undo_button_pressed()
		elif Input.is_action_pressed('Reset'):
			_on_reset_button_pressed()

func _process(_delta):
	var goals = LevelManager.loaded_level.get_node('Goals')
	if _game_end == false && goals: 
		var goal_count = goals.get_child_count()
		for g in goals.get_children():
			if g.occupied:
				goal_count -= 1
				
		if goal_count == 0:
			print("YOU WON!")
			setup_win_timer()
			_timer.start()
			completeScreen.transition()
			_game_end = true

func setup_win_timer():
	_timer = Timer.new()
	_timer.wait_time = 1.8 # 1 second
	_timer.one_shot = true # don't loop, run once
	_timer.autostart = false 
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)

func _on_reset_button_pressed():
	# Hack
	LevelManager.load_next_level(level_list[_level_counter])

func _on_undo_button_pressed():
	var player = LevelManager.loaded_level.get_node('Player')
	var boxes = LevelManager.loaded_level.get_node('Boxes')
	
	if player.lastPlayerPos.size() > 0:
		var undoDict = player.lastPlayerPos.pop_back()
		print(undoDict) # prints state we are reverting to
		var prevBoxPos = undoDict["BoxPos"]
		var prevBoxIndex = undoDict["BoxIndex"]
		player.position = undoDict["PlayerPos"]
		boxes.get_child(prevBoxIndex).position = prevBoxPos

func _on_timer_timeout():
	SceneTransition.transition()
	await SceneTransition.on_transistion_finished
	completeScreen.reset()
	_timer.queue_free()
	_level_counter = _level_counter + 1
	LevelManager.load_next_level(level_list[_level_counter])
	_game_end = false
