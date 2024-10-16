extends Node2D

# Gameplay variables
@export var level_list: Array[PackedScene]
@onready var _completeScreen := $UI/CompleteContainer
@onready var _total_level_count = level_list.size()
var _level_counter: int = 0
var _game_end := false
var _win_timer: Timer = null
var speed_run_timer: Timer = null


func _ready() -> void:
	print(_total_level_count)
	LevelManager.set_main_scene(self)
	LevelManager.load_next_level(level_list[_level_counter])

func _input(event) -> void:
	if !_game_end:
		if Input.is_action_pressed('ui_undo'):
			_on_undo_button_pressed()
		elif Input.is_action_pressed('reset_level'):
			_on_reset_button_pressed()
		elif Input.is_action_pressed('ui_cancel') and not get_tree().paused:
			_open_pause_menu()

func _process(_delta) -> void:
	var goals = LevelManager.loaded_level.get_node('Goals')
	if _game_end == false && goals: 
		var goal_count = goals.get_child_count()
		for g in goals.get_children():
			if g.occupied:
				goal_count -= 1
				
		if goal_count == 0:
			print("YOU WON!")
			setup_win_timer()
			_win_timer.start()
			_completeScreen.transition()
			_game_end = true

func setup_win_timer() -> void:
	_win_timer = Timer.new()
	_win_timer.wait_time = 1.8 # 1 second
	_win_timer.one_shot = true # don't loop, run once
	_win_timer.autostart = false 
	_win_timer.timeout.connect(_on_timer_timeout)
	add_child(_win_timer)

func _on_reset_button_pressed() -> void:
	# Hack - just reload current level
	LevelManager.load_next_level(level_list[_level_counter])

func _on_undo_button_pressed() -> void:
	var player = LevelManager.loaded_level.get_node('Player')
	var boxes = LevelManager.loaded_level.get_node('Boxes')
	
	if player.lastPlayerPos.size() > 0:
		var undoDict = player.lastPlayerPos.pop_back()
		var prevBoxPos = undoDict["BoxPos"]
		var prevBoxIndex = undoDict["BoxIndex"]
		player.position = undoDict["PlayerPos"]
		boxes.get_child(prevBoxIndex).position = prevBoxPos

func _on_timer_timeout() -> void:
	SceneTransition.transition()
	await SceneTransition.on_transistion_finished
	_completeScreen.reset()
	_win_timer.queue_free()
	_level_counter = _level_counter + 1
	
	# If we have beaten all levels move to win screen!
	if _level_counter >= _total_level_count:
		get_tree().change_scene_to_file("res://scenes/menus/you_win.tscn")
	else:
		# Otherwise next level!
		LevelManager.load_next_level(level_list[_level_counter])
		_game_end = false
		
var pause_menu_scene: PackedScene = preload("res://scenes/menus/pause.tscn")
var pause_menu = null
func _open_pause_menu() -> void:
	if not pause_menu:
		pause_menu = pause_menu_scene.instantiate()
		get_tree().root.add_child(pause_menu)
	
	pause_menu.toggle_pause()
	
