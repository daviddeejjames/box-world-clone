extends Node

var main_scene: Node2D = null
var loaded_level: Node2D = null

func set_main_scene(scene: Node2D) -> void:
	main_scene = scene
	
func load_next_level(next_level: PackedScene) -> void:
	if loaded_level != null:
		_unload_level(loaded_level)
	_load_level(next_level)
	
func _load_level(level_to_load: PackedScene) -> void:
	loaded_level = level_to_load.instantiate()
	main_scene.add_child(loaded_level)

func _unload_level(level_to_unload: Node2D) -> void:
	level_to_unload.queue_free()
