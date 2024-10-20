extends Control

func _on_music_value_changed(value: int) -> void:
	AudioManager.update_music_volume(value)

func _on_sfx_value_changed(value: int) -> void:
	AudioManager.update_sfx_volume(value)

func _on_back_pressed() -> void:
	# TODO: Come back to navigating here via Pause Menu
	get_tree().change_scene_to_file("res://scenes//menus/main_menu.tscn")
