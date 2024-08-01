extends CharacterBody2D

const gridSize = 16 

@onready var ray = $RayCast2D

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

# FIXME: Can we avoid side effect here? 
func move(direction):
	var nextPosition = inputs[direction] * gridSize
	if isNextPositionValid(nextPosition):
		self.position += nextPosition 
		return true
	else:
		return false
