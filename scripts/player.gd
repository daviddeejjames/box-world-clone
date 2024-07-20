extends CharacterBody2D

var currentPosition = [0,0]
const gridSize = 16

func _input(event):
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("ui_up"):
		currentPosition[1] -= gridSize
	elif Input.is_action_just_pressed("ui_down"):
		currentPosition[1] += gridSize
	elif Input.is_action_just_pressed("ui_left"):
		currentPosition[0] -= gridSize
	elif Input.is_action_just_pressed("ui_right"):
		currentPosition[0] += gridSize

	print(currentPosition)
	self.position = Vector2(currentPosition[0], currentPosition[1])
