extends Control


func _input(event) -> void: 
	if Input.is_action_just_pressed('ui_cancel') and get_tree().paused:
		_resume_game()
	
func toggle_pause() -> void:
	var paused: bool = get_tree().paused
	if not paused:
		print("GAME PAUSED")
		show()
		AudioManager.toggle_pause_filter(true)
		get_tree().paused = true
	else:
		_resume_game()

func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

func _resume_game() -> void:
	print("GAME RESUMED")
	hide()
	AudioManager.toggle_pause_filter(false)
	get_tree().paused = false
