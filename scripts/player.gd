extends CharacterBody2D

const gridSize = 16 

@onready var ray = $RayCast2D
var lastPlayerPos = []

var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

# Read user input
func _input(event):
	for direction in inputs.keys():
		if Input.is_action_pressed(direction):
			move(direction)

# Does the object in the next position have collision?
func isNextPositionValid(nextPosition):
	ray.target_position = nextPosition
	ray.force_raycast_update()
	return !ray.is_colliding()

func move(direction):
	var nextPosition = inputs[direction] * gridSize
	if isNextPositionValid(nextPosition):
		self.position += nextPosition 
	else: 
		var collider = ray.get_collider()
		if collider.is_in_group('box'):
			if collider.can_move(direction):
				collider.move(direction)
				var undoDict = { 
					"PlayerPos" = self.position,
					"BoxPos" = (self.position + nextPosition),
					"BoxIndex" = collider.get_index()
				}
				lastPlayerPos.push_back(undoDict)
				self.position += nextPosition
