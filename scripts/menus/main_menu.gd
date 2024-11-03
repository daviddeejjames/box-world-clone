extends Control

func _on_play_pressed():
	SceneTransition.transition()
	await SceneTransition.on_transistion_finished
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/options_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
