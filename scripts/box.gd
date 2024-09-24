extends CharacterBody2D

const gridSize = 16 

@onready var ray = $RayCast2D

var inputs = {
	'player_up': Vector2.UP,
	'player_down': Vector2.DOWN,
	'player_left': Vector2.LEFT,
	'player_right': Vector2.RIGHT
}

# Does the object in the next position have collision?	
func isNextPositionValid(nextPosition):
	ray.target_position = nextPosition
	ray.force_raycast_update()
	return !ray.is_colliding()

func can_move(direction):
	var nextPosition = inputs[direction] * gridSize
	if isNextPositionValid(nextPosition):
		return true
	else:
		return false

func move(direction):
	var nextPosition = inputs[direction] * gridSize
	self.position += nextPosition
