extends Node

var _speedrun_time: float = 0.0
var _speedrun_time_string: String = '00 : 00'

func get_speedrun_time() -> float:
	return _speedrun_time

func get_speedrun_time_string() -> String:
	return _speedrun_time_string
	
func update_speedrun_time(delta: float) -> void:
	_speedrun_time += delta
	_speedrun_time_string = _time_to_string(_speedrun_time)
	
func _time_to_string(time: float) -> String:
	var sec = fmod(time, 60)
	var min = time/60
	var format_string = "%02d : %02d"
	return format_string % [min, sec]
