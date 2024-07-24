extends CharacterBody2D

const gridSize = 16 

@onready var ray = $RayCast2D
var lastPosition = []

var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

# Does the object in the next position have collision?	
func isNextPositionValid(nextPosition):
	ray.target_position = nextPosition
	ray.force_raycast_update()
	return !ray.is_colliding()

func move(direction):
	var nextPosition = inputs[direction] * gridSize
	if isNextPositionValid(nextPosition):
		lastPosition.push_back(self.position)
		self.position += nextPosition 
		return true
	else:
		return false
