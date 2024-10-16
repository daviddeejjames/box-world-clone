extends CharacterBody2D

const gridSize = 16 

@onready var ray = $RayCast2D
var lastPlayerPos = []

var inputs = {
	'player_up': Vector2.UP,
	'player_down': Vector2.DOWN,
	'player_left': Vector2.LEFT,
	'player_right': Vector2.RIGHT
}

# Read user input
func _input(event) -> void:
	# TODO prevent diagonal movement
	for direction in inputs.keys():
		if Input.is_action_just_pressed(direction):
			_animate_direction(direction)
			move(direction)

# Does the object in the next position have collision?
func _is_next_position_valid(nextPosition: Vector2) -> bool:
	ray.target_position = nextPosition
	ray.force_raycast_update()
	return !ray.is_colliding()

func move(direction) -> void:
	var nextPosition = inputs[direction] * gridSize
	if _is_next_position_valid(nextPosition):
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

# Animates player sprite depending on direction
func _animate_direction(direction: String) -> void:
	var sprite = $AnimatedSprite2D
	
	match direction:
		'player_up':
			sprite.set_animation('backwards')
		'player_down':
			sprite.set_animation('default')
		'player_left':
			sprite.flip_h = true
			sprite.set_animation('pushing')
		'player_right':
			sprite.flip_h = false
			sprite.set_animation('pushing')
