extends Control

func _on_music_value_changed(value: int) -> void:
	print(value)
	AudioManager.update_music_volume(value)

func _on_sfx_value_changed(value: int) -> void:
	AudioManager.update_sfx_volume(value)
	$GoalSFX.play()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes//menus/main_menu.tscn")
