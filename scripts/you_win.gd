extends Control

func _on_back_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

func _ready():
	# TODO: Play victory music until main menu
	%Time.text = SpeedRunManager.get_speedrun_time_string()
