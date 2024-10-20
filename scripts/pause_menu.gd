extends Control

func pause_game() -> void:
	show()
	AudioManager.toggle_pause_filter(true)
	get_tree().paused = true
	
func resume_game() -> void:
	hide()
	AudioManager.toggle_pause_filter(false)
	get_tree().paused = false

func _on_resume_pressed():
	resume_game()
	
func _on_music_value_changed(value):
	AudioManager.update_music_volume(value)

func _on_sfx_value_changed(value):
	AudioManager.update_sfx_volume(value)
	AudioManager.play_sfx_for_slider()

func _on_quit_pressed():
	resume_game()
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
