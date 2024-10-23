extends Control

@export var win_time: float = 20

func _on_back_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

func _ready():
	# TODO: Get speed run time from game manager scene
	# TODO: Play victory music until main menu
	%Time.text = str(win_time)
